//
//  APIManager.swift
//  MusicVideo
//
//  Created by Estelle qiyu on 2018-04-14.
//  Copyright © 2018 Estelle qiyu. All rights reserved.
//

import Foundation

class APIManager {
    //"completion": result of this func
    //because use another thread (not main thread)
    func loadData(_ urlString:String, completion: @escaping ([Videos]) -> Void ) {
        
        
        let config = URLSessionConfiguration.ephemeral
        
        let session = URLSession(configuration: config)
        
        
        //        let session = NSURLSession.sharedSession()
        let url = URL(string: urlString)!
        
        //data: NSData -> json
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) -> Void in
            
            if error != nil {
                print((error!.localizedDescription))
                
            } else {
                
                //Added for JSONSerialization
                //print(data)
                do {
                    /* .AllowFragments - top level object is not Array or Dictionary.
                     Any type of string or value
                     NSJSONSerialization requires the Do / Try / Catch
                     Converts the NSDATA into a JSON Object and cast it to a Dictionary */
                    // feed & entry, the two layers skipped in Video class
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        as? JSONDictionary,
                        let feed = json["feed"] as? JSONDictionary,
                        let entries = feed["entry"] as? JSONArray{
                        //Video is a self-define class
                        //the logic is all in the class itself, not here
                        var videos = [Videos]()
                        for entry in entries {
                            let entry = Videos(data: entry as! JSONDictionary)
                            videos.append(entry)
                        }
                        
                        let i = videos.count
                        print("iTunesApiManager = totle count --> \(i)")
                        print(" ")
                        
                        ///
                        let priority = DispatchQueue.GlobalQueuePriority.high
                        DispatchQueue.global(priority: priority).async {
                            DispatchQueue.main.async {
                                //videos is what to be passed back
                                completion(videos)
                            }
                        }
                    }
                } catch {
                    print("Error in NSJSONSerialization")
                    
                }
                //End of JSONSerialization
                
            }
        })
        
        task.resume()
    }
    
    
}


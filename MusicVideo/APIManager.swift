//
//  APIManager.swift
//  MusicVideo
//
//  Created by Estelle qiyu on 2018-04-14.
//  Copyright © 2018 Estelle qiyu. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(_ urlString:String, completion: @escaping (_ result:String) -> Void ) {
        
        
        let config = URLSessionConfiguration.ephemeral
        
        let session = URLSession(configuration: config)
        
        
        //        let session = NSURLSession.sharedSession()
        let url = URL(string: urlString)!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) -> Void in
            
            if error != nil {
                DispatchQueue.main.async {
                    completion((error!.localizedDescription))
                }
                
            } else {
                
                //Added for JSONSerialization
                //print(data)
                do {
                    /* .AllowFragments - top level object is not Array or Dictionary.
                     Any type of string or value
                     NSJSONSerialization requires the Do / Try / Catch
                     Converts the NSDATA into a JSON Object and cast it to a Dictionary */
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        as? [String: AnyObject] {
                        
                        print(json)
                        
                        let priority = DispatchQueue.GlobalQueuePriority.high
                        DispatchQueue.global(priority: priority).async {
                            DispatchQueue.main.async {
                                completion("JSONSerialization Successful")
                            }
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion("error in NSJSONSerialization")
                    }
                    
                }
                //End of JSONSerialization
                
            }
        })
        
        task.resume()
    }
    
    
}


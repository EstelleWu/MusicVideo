//
//  APIManager.swift
//  MusicVideo
//
//  Created by Estelle qiyu on 2018-04-14.
//  Copyright © 2018 Estelle qiyu. All rights reserved.
//

import Foundation

import Foundation

class APIManager {
    
    func loadData(_ urlString:String, completion: @escaping (_ result:String) -> Void ) {
        
        
        let config = URLSessionConfiguration.ephemeral
        
        let session = URLSession(configuration: config)
        
        
        //        let session = NSURLSession.sharedSession()
        let url = URL(string: urlString)!
        
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) -> Void in
            
            //have to bring it back to the main queue
            DispatchQueue.main.async {
                if error != nil {
                    completion((error!.localizedDescription))
                } else {
                    completion("NSURLSession successful")
                    print(data)
                }
            }
        })
        task.resume()
    }
    
    
    
    
}

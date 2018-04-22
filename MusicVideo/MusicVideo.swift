//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Estelle qiyu on 2018-04-22.
//  Copyright © 2018 Estelle qiyu. All rights reserved.
//

import Foundation

//get info from the url
class Videos {
    
    // Data Encapsulation
    fileprivate var _vName:String
    fileprivate var _vImageUrl:String
    fileprivate var _vVideoUrl:String
    
    
    //Make a getter
    var vName: String {
        return _vName
    }
    
    var vImageUrl: String {
        return _vImageUrl
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    
    
    init(data: JSONDictionary) {
        
        
        //If we do not initialize all properties we will get error message
        //Return from initializer without initializing all stored properties
        
        
        // Video name
        // name is a dictionary
        if let name = data["im:name"] as? JSONDictionary,
            let vName = name["label"] as? String {
            self._vName = vName
        }
        else
        {
            //You may not always get data back from the JSON - you may want to display message
            // element in the JSON is unexpected
            
            _vName = "No Name Returned"
        }
        
        
        
        // The Video Image
        if let img = data["im:image"] as? JSONArray,
            let image = img[2] as? JSONDictionary,
            let immage = image["label"] as? String {
            //changing the resolution
            _vImageUrl = immage.replacingOccurrences(of: "100x100", with: "600x600")
        }
        else
        {
            _vImageUrl = "No Image Returned"
        }
        
        
        
        //Video Url
        if let video = data["link"] as? JSONArray,
            let vUrl = video[1] as? JSONDictionary,
            let vHref = vUrl["attributes"] as? JSONDictionary,
            let vVideoUrl = vHref["href"] as? String {
            self._vVideoUrl = vVideoUrl
        }
        else
        {
            _vVideoUrl = "No VideoUrl Returned"
        }
        
    }
    
}

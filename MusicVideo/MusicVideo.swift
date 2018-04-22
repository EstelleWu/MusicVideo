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
    fileprivate var _vPrice:String
    fileprivate var _vArtist:String
    fileprivate var _vGenre:String
    fileprivate var _vLinkToiTunes:String
    fileprivate var _vReleaseDte:String
    fileprivate var _vRights:String
    fileprivate var _vImid:String
    
    // "?" means optional
    var vImageData:NSData?
    
    
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
    
    var vPrice: String {
        return _vPrice
    }
    
    var vArtist: String {
        return _vArtist
    }
    
    var vGenre: String {
        return _vGenre
    }
    
    var vLinkToiTunes: String {
        return _vLinkToiTunes
    }
    
    var vReleaseDte:String {
        return _vReleaseDte
    }
    
    var vImid:String {
        return _vImid
    }
    
    var vRights: String {
        return _vRights
    }
    
    
    
    //custom initializer
    //data is already in json format
    //skip some "layers"
    init(data: JSONDictionary) {
        
        
        //If we do not initialize all properties we will get error message
        //Return from initializer without initializing all stored properties
    
        
        // Video name
        // name is a dictionary
        //cast it as JSONDictionary
        if let name = data["im:name"] as? JSONDictionary,
            let vName = name["label"] as? String {
            self._vName = vName
        }
        else
        {
            _vName = "No Name Returned"
        }
        
        
        
        // The Video Image
        if let img = data["im:image"] as? JSONArray,
            let image = img[2] as? JSONDictionary,
            let immage = image["label"] as? String {
            //change the resolution
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
        
        
        // Video Price
        if let price = data["im:price"] as? JSONDictionary,
            let vPrice = price["label"] as? String {
            self._vPrice = vPrice
        }
        else
        {
            _vPrice = "No Price Returned"
        }
        
        // Video Artist
        if let artist = data["im:artist"] as? JSONDictionary,
            let vArtist = artist["label"] as? String {
            self._vArtist = vArtist
        }
        else
        {
            _vArtist = "No Artist Returned"
        }
        
        // Video Genre
        if let category = data["category"] as? JSONDictionary,
            let v_attribute = category["attributes"] as? JSONDictionary,
            let vGenre = v_attribute["term"]as? String {
            self._vGenre = vGenre
        }
        else
        {
            _vGenre = "No Genre Returned"
        }
        
        //Video LinkToiTunes
        if let id = data["im:id"] as? JSONDictionary,
            let vLinkToiTunes = id["label"] as? String {
            self._vLinkToiTunes = vLinkToiTunes
        }
        else
        {
            _vLinkToiTunes = "No Link to iTunes Returned"
        }
        
        // The Release Date
        if let release2 = data["im:releaseDate"] as? JSONDictionary,
            let rel2 = release2["attributes"] as? JSONDictionary,
            let vReleaseDte = rel2["label"] as? String {
            self._vReleaseDte = vReleaseDte
        }
        else
        {
            _vReleaseDte = "No Release Date to iTunes Returned"
        }

        
        // The Artist ID for iTunes Search API
        if let imid = data["id"] as? JSONDictionary,
            let vid = imid["attributes"] as? JSONDictionary,
            let vImid = vid["im:id"] as? String {
            self._vImid = vImid
        }
        else
        {
            _vImid = "No Artist ID to iTunes Returned"
        }
        
        // The Studio Name
        if let rights = data["rights"] as? JSONDictionary,
            let vRights = rights["label"] as? String {
            self._vRights = vRights
        }
        else
        {
            _vRights = "No Studio Name to iTunes Returned"
        }
    }
    
}

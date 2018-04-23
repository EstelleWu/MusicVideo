//
//  ViewController.swift
//  MusicVideo
//
//  Created by Estelle qiyu on 2018-04-14.
//  Copyright © 2018 Estelle qiyu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var videos = [Videos]()
    
    @IBOutlet weak var displayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //refer back to appDelegate
        NotificationCenter.default.addObserver(self, selector: "reachabilityStatusChanged:", name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        //in case reachabilityStatus changed again
        reachabilityStatusChanged()
        
        //Call API
        let api = APIManager()
        //load, completed and then didLoadData
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }
    
    func didLoadData(videos: [Videos]) {
        print(reachabilityStatus)
        self.videos = videos
        
        //videos is not applicable for this scope
        for item in videos{
            print("name = \(item.vName)")
        }
        
        for (index, item) in videos.enumerated(){
            print("\(index) name = \(item.vName)")
        }
        
    }
    
    func reachabilityStatusChanged()
    {
        
        switch reachabilityStatus {
        case NOACCESS : view.backgroundColor = UIColor.red
        displayLabel.text = "No Internet"
        case WIFI : view.backgroundColor = UIColor.green
        displayLabel.text = "Reachable with WIFI"
        case WWAN : view.backgroundColor = UIColor.yellow
        displayLabel.text = "Reachable with Cellular"
        default:return
        }
        
    }
    
    // Is called just as the object is about to be deallocated
    // because obverver was added
    deinit
    {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
    }
    


}


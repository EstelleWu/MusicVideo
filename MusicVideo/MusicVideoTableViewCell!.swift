//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by Estelle qiyu on 2018-04-24.
//  Copyright © 2018 Estelle qiyu. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {
    
    var video: Videos? {
        didSet {
            updateCell()
        }
    }

    @IBOutlet weak var musicImage: UIImageView!

    @IBOutlet weak var rank: UILabel!

    @IBOutlet weak var musicTitle: UILabel!


    func updateCell(){
        musicTitle.text = video?.vName
        rank.text = ("\(video!.vRank)")
        //musicImage.image = UIImage(named: "imageNotAvailable")
        
        if video!.vImageData != nil {
            print("Get data from array ...")
            musicImage.image = UIImage(data: video!.vImageData! as Data)
        }
        else
        {
            GetVideoImage(video!, imageView: musicImage)
            
        }
    }

    func GetVideoImage(_ video: Videos, imageView : UIImageView){
        
        // Background thread
        //  DISPATCH_QUEUE_PRIORITY_HIGH Items dispatched to the queue will run at high priority, i.e. the queue will be scheduled for execution before any default priority or low priority queue.
        //
        //  DISPATCH_QUEUE_PRIORITY_DEFAULT Items dispatched to the queue will run at the default priority, i.e. the queue will be scheduled for execution after all high priority queues have been scheduled, but before any low priority queues have been scheduled.
        //
        //  DISPATCH_QUEUE_PRIORITY_LOW Items dispatched to the queue will run at low priority, i.e. the queue will be scheduled for execution after all default priority and high priority queues have been scheduled.
        
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
            //                               url <- string      vImageUrl comes from the array
            let data = try? Data(contentsOf: URL(string: video.vImageUrl)!)
            
            var image : UIImage?
            if data != nil {
                if data != nil {
                    video.vImageData = data as! NSData as Data
                    image = UIImage(data: data!)
                }
            
            // move back to Main Queue
            DispatchQueue.main.async {
                // return
                imageView.image = image
            }
        }
    }
    }
}

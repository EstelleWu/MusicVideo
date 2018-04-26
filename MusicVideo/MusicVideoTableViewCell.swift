//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by Estelle qiyu on 2018-04-22.
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
    
    func updateCell() {
        musicTitle.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        rank.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        musicTitle.text = video?.vName
        rank.text = ("\(video!.vRank)")
        
        //musicImage.image = UIImage(named: "imageNotAvailable")
        
        if video!.vImageData != nil {
            //already loaded
            print("Get data from array ...")
            musicImage.image = UIImage(data: video!.vImageData! as Data)
        }
        else
        {
           GetVideoImage(video!, imageView: musicImage)
            print("Get images in background thread")
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
            
            let data = try? Data(contentsOf: URL(string: video.vImageUrl)!)
            
            var image : UIImage?
            if data != nil {
                video.vImageData = (data as! NSData) as Data as Data as NSData
                image = UIImage(data: data!)
            }
            
            // move back to Main Queue
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
 
}

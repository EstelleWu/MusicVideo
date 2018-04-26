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
        musicImage.image = UIImage(named: "imageNotAvailable")
    }

}

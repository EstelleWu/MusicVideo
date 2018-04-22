//
//  ViewController.swift
//  MusicVideo
//
//  Created by Estelle qiyu on 2018-04-14.
//  Copyright © 2018 Estelle qiyu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call API
        let api = APIManager()
        //load, completed and then didLoadData
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }
    
    func didLoadData(_ result:String) {
        
        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { action -> Void in
            //do something if you want
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    
}


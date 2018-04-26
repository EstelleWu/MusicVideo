//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by Estelle qiyu on 2018-04-22.
//  Copyright © 2018 Estelle qiyu. All rights reserved.
//

import UIKit
//bound to the tableViewController in the main story board
class MusicVideoTVC: UITableViewController {

    var videos = [Videos]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //refer back to appDelegate
        NotificationCenter.default.addObserver(self, selector: "reachabilityStatusChanged:", name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        //aautomatically, don't have to cloase the app
        NotificationCenter.default.addObserver(self, selector: "preferredFontChange:", name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
        //in case reachabilityStatus changed again
        reachabilityStatusChanged()
        
        
    }
    
    func preferredFontChange(){
        print("the revert font has change")
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
        
        tableView.reloadData()
    }
    
    func reachabilityStatusChanged()
    {
        
        
        switch reachabilityStatus {
        case NOACCESS :
            view.backgroundColor = UIColor.red
            // move back to Main Queue
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internet", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
                    action -> () in
                    print("Cancel")
                }
                // "destructive" red
                let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {
                    action -> () in
                    print("delete")
                }
                let okAction = UIAlertAction(title: "ok", style: .default) { action -> Void in
                    print("Ok")
                    
                    //do something if you want
                    //alert.dismissViewControllerAnimated(true, completion: nil)
                }
                
                //the order show on the screen
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                alert.addAction(deleteAction)
                
                
                self.present(alert, animated: true, completion: nil)
            }
            
        default:
            //view.backgroundColor = UIColor.green
            // if (run the api before), otherwise video.count would be null
            // already has the API built
            if videos.count > 0 {
                print("do not refresh API")
            } else {
                runAPI()    
                
            }
            
        }
        
    }
    func runAPI(){
        //Call API
        let api = APIManager()
        //load, completed and then didLoadData
        //iTunes REST API
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json", completion: didLoadData)
    }
    // Is called just as the object is about to be deallocated
    // because obverver was added
    deinit
    {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }

    private struct storyboard{
        static let cellReuseIdentifier = "cell"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //connect to class "MusicVideoTableViewCell"
        //just put in the cell, not logic
        let cell = tableView.dequeueReusableCell(withIdentifier: storyboard.cellReuseIdentifier, for: indexPath) as! MusicVideoTableViewCell

        cell.video = videos[indexPath.row]
        
//        cell.textLabel?.text = ("\(indexPath.row + 1)")
//        
//        cell.detailTextLabel?.text = video.vName


        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

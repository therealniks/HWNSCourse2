//
//  FeedTableViewController.swift
//  Course2
//
//  Created by N!kS on 20.12.2020.
//

import UIKit

class FeedTableViewController: UITableViewController {

    let news = [Feed(feedText: "1", feedCommentCount: 15, feedShareCount: 1, feedLikeCount: 15, feedLogo: UIImage(named: "avatar")!),
                Feed(feedText: "2", feedCommentCount: 100, feedShareCount: 2, feedLikeCount: 18, feedLogo: UIImage(named: "avatar")!),
                Feed(feedText: "3", feedCommentCount: 90, feedShareCount: 3, feedLikeCount: 19, feedLogo: UIImage(named: "avatar")!),
                Feed(feedText: "4", feedCommentCount: 14, feedShareCount: 4, feedLikeCount: 6, feedLogo: UIImage(named: "avatar")!),
                Feed(feedText: "5", feedCommentCount: 678, feedShareCount: 5, feedLikeCount: 15, feedLogo: UIImage(named: "avatar")!)]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(UINib(nibName: "FeedCell", bundle: nil),
                           forCellReuseIdentifier: "MyFeedCell")
    }

    // MARK: - Table view data source

  /*  override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        news.count
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyFeedCell", for: indexPath)
            as? FeedCell
              else {return UITableViewCell()}
        cell.feedCommentCount.text = String(news[indexPath.row].feedCommentCount)
        cell.feedShareCount.text =  String(news[indexPath.row].feedCommentCount)
        cell.feedLikeCount.text = String(news[indexPath.row].feedCommentCount)
        cell.feedText.text = String(news[indexPath.row].feedCommentCount)
        //cell.feedImage.images = news[indexPath.row].feedLogo
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

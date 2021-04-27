//
//  MyFriendsTableViewController.swift
//  Course2
//
//  Created by N!kS on 09.12.2020.
//

import UIKit
import Kingfisher
import RealmSwift

class MyFriendsTableViewController: UITableViewController, UISearchBarDelegate {
var networkService = NetworkService()

    var myFriends = [Friend]()
    private var filtredFriends = [Character : [Friend]]()
    @IBOutlet weak var searchBar : UISearchBar!
    var searching:Bool = false
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        networkService.getFriends(for: UserSession.instance.id){ [weak self] myFriends in
            self?.myFriends = myFriends
            self?.tableView.reloadData()
            }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFriends.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath)
                as? FriendsCell
        else { return UITableViewCell() }
        cell.configure(with: myFriends[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FriendsCell
        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
        cell.friendAvatar.transform = scale
        cell.friendAvatar.alpha = 0.5
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: [.curveEaseInOut],
                       animations: {
                        cell.friendAvatar.transform = .identity
                        cell.friendAvatar.alpha = 1
                        
        })
    }
}

extension MyFriendsTableViewController {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            //myFriends = user
            tableView.reloadData()
            return
        }
       // myFriends = user.filter("lastName BEGINSWITH '\(searchBar.text!)'")
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        tableView.endEditing(true)
        tableView.reloadData()
    }

//    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        searchBar.text = ""
//        tableView.endEditing(true)
//        tableView.reloadData()
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profilePhoto"{
            let profilePC = segue.destination as! ProfileCollectionController
            let indexPath = self.tableView.indexPathForSelectedRow
            let friend = self.myFriends[indexPath!.row]
            profilePC.id = (friend.id)
            }
        }
}





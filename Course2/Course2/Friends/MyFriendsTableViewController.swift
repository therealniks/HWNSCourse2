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

    lazy var myFriends = networkService.realm.objects(Friends.self)
    lazy var user = networkService.realm.objects(Friends.self)
    var token: NotificationToken?

    var filtredFriends = [Character : [Friends]]()
    @IBOutlet weak var searchBar : UISearchBar!
    var searching:Bool = false
    

    
    func notification(){
            token = myFriends.observe({ (changes: RealmCollectionChange) in
                switch changes{
                case .initial(let result):
                    print(result)
                case.update(_, deletions: _, insertions: _, modifications: _):
                    self.tableView.reloadData()
                case.error(let error):
                    print(error.localizedDescription)
                }
            })
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        networkService.getFriends(for: UserSession.instance.id){ [weak self] in
            self?.loadFriendsData(for: UserSession.instance.id)
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
        let url = URL(string: myFriends[indexPath.row].icon)
        let firstName = myFriends[indexPath.row].firstName
        let lastName = myFriends[indexPath.row].lastName
        cell.friendAvatar.photoImage.kf.setImage(with: url)
        cell.friendID.text = "\(firstName) \(lastName)"
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
            myFriends = user
            tableView.reloadData()
            return
        }
        myFriends = user.filter(" lastName BEGINSWITH '\(searchBar.text!)'")
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        tableView.endEditing(true)
        tableView.reloadData()
    }
    

    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.text = ""
        tableView.endEditing(true)
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profilePhoto"{
            let profilePC = segue.destination as! ProfileCollectionController
            let indexPath = self.tableView.indexPathForSelectedRow
            let friend = self.myFriends[indexPath!.row]
                profilePC.id = (friend.id)
                print("id for photos is")
                print(profilePC.id)
            }
        }
        
    
    
    func loadFriendsData(for id: Int){
        do {
            let realm = try Realm()
            let friend = realm.objects(Friends.self)
            self.myFriends = friend
            }catch{
                print ( error)
            }
        
    }   
}

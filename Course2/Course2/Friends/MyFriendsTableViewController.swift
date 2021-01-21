//
//  MyFriendsTableViewController.swift
//  Course2
//
//  Created by N!kS on 09.12.2020.
//

import UIKit
import Kingfisher
class MyFriendsTableViewController: UITableViewController, UISearchBarDelegate {

    var myFriends = [Friends]()
    var nFriends = [String]()
    var filtredFriend = [Friends]()
    var firstLetters = [Character]()
    var sortedFriends = [Character : [Friends]]()
    var filtredFriends = [Character : [Friends]]()
    @IBOutlet weak var searchBar : UISearchBar!
    var searching:Bool = false
    
    
    
    
    
    
    
    private func sort(_ users: [Friends])->(characters: [Character], sortedUsers: [Character:[Friends]] ){
            var characters = [Character]()
            var sortedUsers = [Character : [Friends]]()
        users.forEach { user in
            guard let character = user.lastName.first else {return}
            if var thisCharUsers = sortedUsers[character]{
                thisCharUsers.append(user)
                sortedUsers[character] = thisCharUsers
            } else {
                sortedUsers[character] = [user]
                characters.append(character)
            }
        }
        characters.sort()
        return (characters,sortedUsers)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        (firstLetters, sortedFriends) = sort(myFriends)
        let usersFriends = Requests()
            usersFriends.getFriends(for: UserSession.instance.id){ [weak self]
            myFriends in
            self?.myFriends = myFriends
            self?.tableView.reloadData()
                print(myFriends.count)
            }
        
        
        
        
            
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if searching{
          return  filtredFriend.count
        }else{
            return 1
        }
    }

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        // #warning Incomplete implementation, return the number of rows
    // let charUsers = firstLetters[section]
    return  myFriends.count//sortedFriends[charUsers]?.count ?? 1  //

   }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath)
                as? FriendsCell
        else { return UITableViewCell() }
       // let firstLetter = firstLetters[indexPath.section]
      //  if let myFriends = sortedFriends[firstLetter]{
            if searching{
                cell.friendID.text = filtredFriend[indexPath.row].firstName// + " " + filtredFriend[indexPath.row].name
                    // cell.friendAvatar.photoImage.image = filtredFriend[indexPath.row].avatar
           }else{
        cell.friendID.text = myFriends[indexPath.row].firstName + " " + myFriends[indexPath.row].lastName
        cell.friendAvatar.photoImage.kf.setImage(with: URL(string: myFriends[indexPath.row].icon))
                       }
        //}
        
        return cell
    }
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//            return 1 //String(firstLetters[section])
//    }
     override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        Array(firstLetters).map { String($0)}
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
        searching = true
        filtredFriend = myFriends.filter{$0.firstName.prefix(searchText.count) == searchText}
        tableView.reloadData()
        }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.endEditing(true)
        tableView.reloadData()
    }
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searching = false
        searchBar.text = ""
        tableView.endEditing(true)
        tableView.reloadData()
    }
}

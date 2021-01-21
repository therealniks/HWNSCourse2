//
//  MyFriendsTableViewController.swift
//  Course2
//
//  Created by N!kS on 09.12.2020.
//

import UIKit

class MyFriendsTableViewController: UITableViewController {

    let myFriends = [User(id: 1, name: "Ivan", surname: "Petrov"),
                     User(id: 2, name: "Petr", surname: "Ivanov"),
                     User(id: 3, name: "Genadiy", surname:"Generalov"),
                     User(id: 4, name: "Andriy", surname: "Sidorov")]
    var filtredFriend = [User]()
    var firstLetters = [Character]()
    var sortedFriends = [Character : [User]]()
    var filtredFriends = [Character : [User]]()
    @IBOutlet weak var searchBar : UISearchBar!
    var searching:Bool = false
    
    private func sort(_ users: [User])->(characters: [Character], sortedUsers: [Character:[User]] ){
            var characters = [Character]()
            var sortedUsers = [Character : [User]]()
        users.forEach { user in
            guard let character = user.surname.first else {return}
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
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems=[
            URLQueryItem.init(name: "user_id", value: "71613812"),
            URLQueryItem(name: "access_token", value: UserSession.instance.token),
            URLQueryItem(name: "v", value: "5.126"),
            URLQueryItem(name: "fields", value: "city"),
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        let task = session.dataTask (with : request )
        { ( data , response , error ) in
        let json = try? JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.allowFragments)
        print(json ?? "false")
        }
        task.resume()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if searching{
          return  filtredFriend.count
        }else{
            return firstLetters.count
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let charUsers = firstLetters[section]
        return sortedFriends[charUsers]?.count ?? 0
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath)
                as? FriendsCell
        else { return UITableViewCell() }
        let firstLetter = firstLetters[indexPath.section]
        if let users = sortedFriends[firstLetter]{
            if searching{
                cell.friendID.text = filtredFriend[indexPath.row].surname + " " + filtredFriend[indexPath.row].name
                cell.friendAvatar.photoImage.image = filtredFriend[indexPath.row].avatar
            }else{
                cell.friendID.text = users[indexPath.row].surname + " " + users[indexPath.row].name
                cell.friendAvatar.photoImage.image = users[indexPath.row].avatar
                
            }
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return String(firstLetters[section])
    }
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




extension MyFriendsTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searching = true
        filtredFriend = myFriends.filter{$0.surname.prefix(searchText.count) == searchText}
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





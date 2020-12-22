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
    
    var firstLetters = [Character]()
    var sortedFriends = [Character : [User]]()
    
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
        (firstLetters, sortedFriends) = sort(myFriends)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        firstLetters.count
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
        cell.friendID.text = users[indexPath.row].surname + " " + users[indexPath.row].name
            cell.friendAvatar.photoImage.image = users[indexPath.row].avatar
            
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(firstLetters[section])
    }
     override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        Array(firstLetters).map { String($0)}
    }
}


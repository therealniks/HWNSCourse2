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
                     User(id: 3, name: "Genadiy", surname:"Generalov")]
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        myFriends.count

    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath)
                as? FriendsCell
        else { return UITableViewCell() }
        cell.friendID.text = myFriends[indexPath.row].surname + " " + myFriends[indexPath.row].name
        cell.friendAvatar.photoImage.image = myFriends[indexPath.row].avatar

        return cell
    }
}

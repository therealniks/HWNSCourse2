//
//  AllGroupsTableViewController.swift
//  Course2
//
//  Created by N!kS on 09.12.2020.
//

import UIKit

class AllGroupsTableViewController: UITableViewController {

    var groups = [Group(id: 1, title: "C++", description: "Stronger"),
                  Group(id: 2, title: "C#", description: ".NET"),
                  Group(id: 3, title: "Swift", description: "Simply"),
                  Group(id: 4, title: "python", description: "beautiful")]

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath)
        as? AllGroupsCell
        else { return UITableViewCell() }
        cell.groupImage.image = groups[indexPath.row].avatar
        cell.groupLabel.text = groups[indexPath.row].title


        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

 

}

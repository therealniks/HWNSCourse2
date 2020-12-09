//
//  MyGroupsViewController.swift
//  Course2
//
//  Created by N!kS on 09.12.2020.
//

import UIKit

class MyGroupsViewController: UITableViewController {

var myGroups = [Group]()

    // MARK: - Table view data source
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            segue.identifier == "addGroup",
            let controller = segue.source as? AllGroupsTableViewController,
            let indexPath = controller.tableView.indexPathForSelectedRow,
            !myGroups.elementsEqual(controller.groups, by: { $0.title == $1.title })
        else { return }
        myGroups.append(controller.groups[indexPath.row])
        tableView.reloadData()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath)
                as? MyGroupsCell
        else { return UITableViewCell() }
        cell.MyGroupAvatar.image = myGroups[indexPath.row].avatar
        cell.MyGroupTitle.text = myGroups[indexPath.row].title

        return cell
    }

}

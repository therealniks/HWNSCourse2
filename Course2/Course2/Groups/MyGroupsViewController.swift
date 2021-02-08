//
//  MyGroupsViewController.swift
//  Course2
//
//  Created by N!kS on 09.12.2020.
//

import UIKit

class MyGroupsViewController: UITableViewController {

var myGroups = [Groups]()

    // MARK: - Table view data source
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            segue.identifier == "addGroup",
            let controller = segue.source as? AllGroupsTableViewController,
            let indexPath = controller.tableView.indexPathForSelectedRow,
            !myGroups.contains(where: {$0.name == controller.myGroups[indexPath.row].name})
        else { return }
        myGroups.append(controller.myGroups[indexPath.row])
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myGroups.count
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath)
                as? MyGroupsCell
        else { return UITableViewCell() }
        cell.MyGroupAvatar.kf.setImage(with: URL(string: myGroups[indexPath.row].icon))
        cell.MyGroupTitle.text = myGroups[indexPath.row].name
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let userGroups = Requests()
       // userGroups.getGroups()

}
}

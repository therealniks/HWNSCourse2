//
//  MyGroupsViewController.swift
//  Course2
//
//  Created by N!kS on 09.12.2020.
//

import UIKit
import RealmSwift
import FirebaseDatabase

class MyGroupsViewController: UITableViewController {

private var myGroups = [FireBaseMyGroups]()
    private let ref = Database.database().reference(withPath: "myGroups")
    // MARK: - Table view data source
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            segue.identifier == "addGroup",
            let controller = segue.source as? AllGroupsTableViewController,
            let indexPath = controller.tableView.indexPathForSelectedRow
        else {return}
        
            let groupName = controller.allGroups[indexPath.row].name
            let groupIcon = controller.allGroups[indexPath.row].icon
            let group = FireBaseMyGroups(name:groupName, iconURL: groupIcon)
            let groupRef = self.ref.child(controller.allGroups[indexPath.row].name.lowercased())
            groupRef.setValue(group.toAnyObject())
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myGroups.count
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let group = myGroups[indexPath.row]
            group.ref?.removeValue()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath)
                as? MyGroupsCell
        else { return UITableViewCell() }
        let group = myGroups[indexPath.row]
        cell.MyGroupAvatar.kf.setImage(with: URL(string: group.iconURL))
        cell.MyGroupTitle.text = group.name
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref.observe(.value, with: {snapshot in
            var groups: [FireBaseMyGroups] = []
            for child in snapshot.children{
                if let snapshot = child as? DataSnapshot,
                   let group = FireBaseMyGroups(snapshot: snapshot){
                    groups.append(group)
                }
            }
            self.myGroups = groups
            self.tableView.reloadData()
        })
        }

}
    


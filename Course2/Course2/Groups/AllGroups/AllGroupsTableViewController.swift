//
//  AllGroupsTableViewController.swift
//  Course2
//
//  Created by N!kS on 09.12.2020.
//

import UIKit
import RealmSwift

class AllGroupsTableViewController: UITableViewController {

    var myGroups = [Groups]()

    // MARK: - Table view data source
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let usersAllGroups = Requests()
        usersAllGroups.getGroups(for: UserSession.instance.id){ [weak self] in
            self?.loadGroupsData(for: UserSession.instance.id)
            self?.tableView.reloadData()

            }
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myGroups.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath)
        as? AllGroupsCell
        else { return UITableViewCell() }
        cell.groupImage.kf.setImage(with: URL(string: myGroups[indexPath.row].icon))
        cell.groupLabel.text = myGroups[indexPath.row].name
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


    private func loadGroupsData(for id: Int){
        do {
            let realm = try Realm()
            let groups = realm.objects(Groups.self)
            self.myGroups = Array(groups)
            }catch{
                print ( error.localizedDescription)
            }
        
        }
    }

//
//  AllGroupsTableViewController.swift
//  Course2
//
//  Created by N!kS on 09.12.2020.
//

import UIKit
import RealmSwift

class AllGroupsTableViewController: UITableViewController {
    var networkService = NetworkService()
    lazy var myAllGroups = networkService.realm.objects(Groups.self)

    // MARK: - Table view data source
   
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.getGroups(for: UserSession.instance.id){ [weak self] in
            self?.loadGroupsData(for: UserSession.instance.id)
            self?.tableView.reloadData()

            }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myAllGroups.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath)
        as? AllGroupsCell
        else { return UITableViewCell() }
        cell.groupImage.kf.setImage(with: URL(string: myAllGroups[indexPath.row].icon))
        cell.groupLabel.text = myAllGroups[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    private func loadGroupsData(for id: Int){
        do {
            let realm = try Realm()
            let groups = realm.objects(Groups.self)
            self.myAllGroups = groups
            }catch{
                print ( error.localizedDescription)
            }
        
        }
    }

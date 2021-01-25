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
            !myGroups.contains(where: {$0.id == controller.groups[indexPath.row].id})
        else { return }
        myGroups.append(controller.groups[indexPath.row])
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
        cell.MyGroupAvatar.image = myGroups[indexPath.row].avatar
        cell.MyGroupTitle.text = myGroups[indexPath.row].title
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems=[
            URLQueryItem.init(name: "user_id", value: "71613812"),
            URLQueryItem(name: "access_token", value: UserSession.instance.token),
            URLQueryItem(name: "v", value: "5.126"),
            URLQueryItem(name: "extended", value: "1"),
        ]
        let request = URLRequest(url: urlComponents.url!)
        let task = session.dataTask (with : request )
        {(data , response , error ) in
        let json = try? JSONSerialization.jsonObject(with: data!,
                        options:JSONSerialization.ReadingOptions.allowFragments)
        print(json ?? "false")
        }
        task.resume()}

}

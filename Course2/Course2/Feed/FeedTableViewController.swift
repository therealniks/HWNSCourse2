//
//  FeedTableViewController.swift
//  Course2
//
//  Created by N!kS on 20.12.2020.
//

import UIKit

class FeedTableViewController: UITableViewController {

    var feed : [Feed]? {
        didSet {
            self.tableView.reloadData()
        }
        
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(HeaderCell.nib,
                                forCellReuseIdentifier: HeaderCell.reuseIdentifier)
        self.tableView.register(BodyCell.nib,
                                forCellReuseIdentifier: BodyCell.reuseIdentifier)
        self.tableView.register(FooterCell.nib,
                                forCellReuseIdentifier: FooterCell.reuseIdentifier)
        getFeed(){news in
            self.feed = news
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        self.feed?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       3
    }
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            guard
                let feed = self.feed?[indexPath.section],
                let headerCell = self.tableView.dequeueReusableCell(withIdentifier: HeaderCell.reuseIdentifier) as? HeaderCell
            else {return HeaderCell()}
            headerCell.configure(with: feed)
            return headerCell
        case 1:
            guard
                let feed = self.feed?[indexPath.section],
                let bodyCell = self.tableView.dequeueReusableCell(withIdentifier: BodyCell.reuseIdentifier) as? BodyCell
            else {return BodyCell()}
            bodyCell.configure(with: feed)
            return bodyCell
        case 2:
            guard
                let feed = self.feed?[indexPath.section],
                let footerCell = self.tableView.dequeueReusableCell(withIdentifier: FooterCell.reuseIdentifier) as? FooterCell
            else {return FooterCell()}
            footerCell.configure(with: feed)
            return footerCell
        default:
            return UITableViewCell()
        }
    
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 475
        case 1:
            return 350
        default:
            return 100
        }
    }


}

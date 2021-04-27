//
//  FeedTableViewController.swift
//  Course2
//
//  Created by N!kS on 20.12.2020.
//

import UIKit
import RealmSwift

class FeedTableViewController: UITableViewController {
    let networkService =  NetworkService()
    lazy var feed = networkService.realm.objects(Feed.self)

    var token : NotificationToken?
    func notification(){
            token = feed.observe({ (changes: RealmCollectionChange) in
                switch changes{
                case .initial(let result):
                    print(result)
                case.update(_, deletions: _, insertions: _, modifications: _):
                    self.tableView.reloadData()
                case.error(let error):
                    print(error.localizedDescription)
                }
            })
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(HeaderCell.nib,
                                forCellReuseIdentifier: HeaderCell.reuseIdentifier)
        self.tableView.register(BodyCell.nib,
                                forCellReuseIdentifier: BodyCell.reuseIdentifier)
        self.tableView.register(FooterCell.nib,
                                forCellReuseIdentifier: FooterCell.reuseIdentifier)
        DispatchQueue.global().async(flags: .barrier){
            self.networkService.getFeed {feed, newsProfiles , newsGroups  in
                self.loadFeed()
                try? RealmProvider.save(items: feed)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.notification()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        self.feed.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row{
        case 0:
            //guard
                let feed = self.feed[indexPath.section]
                let headerCell = self.tableView.dequeueReusableCell(withIdentifier: HeaderCell.reuseIdentifier) as? HeaderCell
                
            //else {return HeaderCell()}
            headerCell?.configure(with: feed)
            return headerCell!
        case 1:
            //guard
                let feed = self.feed[indexPath.section]
                let bodyCell = self.tableView.dequeueReusableCell(withIdentifier: BodyCell.reuseIdentifier) as? BodyCell
            //else {return BodyCell()}
            bodyCell?.configure(with: feed)
            return bodyCell!
        case 2:
            //guard
                let feed = self.feed[indexPath.section]
                let footerCell = self.tableView.dequeueReusableCell(withIdentifier: FooterCell.reuseIdentifier) as? FooterCell
           // else {return FooterCell()}
            footerCell?.configure(with: feed)
            return footerCell!
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
            return 275
        case 1:
            return 350
        default:
            return 100
        }
    }
    
    func loadFeed(){
        do {
            let realm = try Realm()
            let news = realm.objects(Feed.self)
            self.feed = news
            }catch{
                print ( error)
            }
    }
}

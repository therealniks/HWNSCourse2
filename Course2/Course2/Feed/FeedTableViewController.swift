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
    var feed = [Feed]()
    var photoService : PhotoService?
    private var nextFrom = ""
    private var isFetching: Bool = false
    private var expandedCells = [IndexPath: Bool]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(HeaderCell.nib,
                                forCellReuseIdentifier: HeaderCell.reuseIdentifier)
        self.tableView.register(TextCell.nib,
                                forCellReuseIdentifier: TextCell.reuseIdentifier)
        self.tableView.register(BodyCell.nib,
                                forCellReuseIdentifier: BodyCell.reuseIdentifier)
        self.tableView.register(FooterCell.nib,
                                forCellReuseIdentifier: FooterCell.reuseIdentifier)

        DispatchQueue.global().async(flags: .barrier){
            self.networkService.getFeed {[weak self] feed, newsProfiles , newsGroups, nextFrom in
                self?.nextFrom = nextFrom
                self?.feed.append(contentsOf: feed)
                self?.tableView.reloadData()
            }
            
        }
        photoService = PhotoService(container: tableView)
        configateRefreshControl()
        
        tableView.prefetchDataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Private Methods
    private func configateRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .systemGray
        refreshControl?.attributedTitle = NSAttributedString(string: "Updating…")
        refreshControl?.addTarget(self,
                                  action: #selector(refreshTableView),
                                  for: .valueChanged)
        
    }
    
    // MARK: - View action
    @objc
    private func refreshTableView() {
        let startTime = feed.first?.authorDate ?? Date().timeIntervalSince1970
        DispatchQueue.global().async {
            self.networkService.getFeed(startTime: startTime) {[weak self] (feed, friends, groups, nextFrom)  in
                self?.feed = feed + (self?.feed ?? [])
                self?.nextFrom = nextFrom
                self?.refreshControl?.endRefreshing()
        }

        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        self.feed.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let feed = self.feed[indexPath.section]
            let headerCell = self.tableView.dequeueReusableCell(withIdentifier: HeaderCell.reuseIdentifier) as? HeaderCell
            headerCell?.configure(with: feed)
            return headerCell!
        case 1:
            let feed = self.feed[indexPath.section]
            let textCell = self.tableView.dequeueReusableCell(withIdentifier: TextCell.reuseIdentifier) as? TextCell
            textCell?.delegate = self
            textCell?.configure(with: feed,
                                indexPath: indexPath)
            return textCell!
            
        case 2:
            let photo = self.feed[indexPath.section]
            let bodyCell = self.tableView.dequeueReusableCell(withIdentifier: BodyCell.reuseIdentifier) as? BodyCell
            bodyCell?.configure(with: photo, by: photoService!)
            return bodyCell!
        case 3:
            let feed = self.feed[indexPath.section]
            let footerCell = self.tableView.dequeueReusableCell(withIdentifier: FooterCell.reuseIdentifier) as? FooterCell
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
            return 80
        case 1:
            let text = feed[indexPath.section].text
            let textSize = getLabelSize(text: text,
                                        font: UIFont.systemFont(ofSize: 17.0),
                                        maxWidth: tableView.bounds.width)
            let expanded = expandedCells[indexPath] ?? false
            if expanded {
                return textSize.height + 8
            } else {
                return min(textSize.height, 200)
            }
        case 2:
            let tableWidth = tableView.bounds.width
            let news = feed[indexPath.section]
            return tableWidth * news.aspectRatio
        default:
            return UITableView.automaticDimension
        }
    }
    
    private func getLabelSize(text: String, font: UIFont, maxWidth: CGFloat) -> CGSize {
        let textblock = CGSize(width: maxWidth, height: .greatestFiniteMagnitude)
        let rect = text.boundingRect(with: textblock,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font: font],
                                     context: nil)
        let width = rect.width.rounded(.up)
        let height = rect.height.rounded(.up)
        return CGSize(width: width, height: height)
    }
}

extension FeedTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section}).max() else { return }
        if
            maxSection > feed.count - 4,
            !isFetching {
            isFetching.toggle()
            networkService.getFeed(startFrom: nextFrom) { [weak self] (feeds, friends, groups, nextFrom) in
                self?.feed.append(contentsOf: feeds)
                self?.nextFrom = nextFrom
                self?.tableView.reloadData()
                self?.isFetching.toggle()
            }
        }
    }
}

extension FeedTableViewController: AnyTextCell {
    func textCellTapped(at indexPath: IndexPath) {
        var expanded = expandedCells[indexPath] ?? false
        expanded.toggle()
        expandedCells[indexPath] = expanded
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

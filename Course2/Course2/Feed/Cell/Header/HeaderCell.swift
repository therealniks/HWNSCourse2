//
//  HeaderCell.swift
//  Course2
//
//  Created by N!kS on 03.03.2021.
//

import UIKit
import RealmSwift
import Kingfisher

class HeaderCell: UITableViewCell {
    static var reuseIdentifier: String { String(describing: self) }
    static var nib: UINib {
        return UINib(nibName: String(describing: self),
                     bundle: nil)
    }
    @IBOutlet weak var feedAuthor: UILabel!
    @IBOutlet weak var feedAuthorImage : FriendAvatarImageView!
    @IBOutlet weak var feedAuthorTime : UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.feedAuthor.text = nil
        self.feedAuthorImage.image = nil
        self.feedAuthorTime.text = nil
    }
    func configure(with feed: Feed?) {
        guard var sourceID = feed?.sourceID else {return}
        guard sourceID != 0 else {return}
        var photoURL : String = ""
        var author: String = ""
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        let date = Date(timeIntervalSince1970: TimeInterval(feed!.authorDate))
        if sourceID > 0 {
            guard 
                  let source = try? Realm().objects(Friend.self).filter("id == %@", sourceID),
                  let friend = source.first
                  else {return}
            photoURL = friend.icon
            author = (friend.lastName + " " + friend.firstName)
        } else{
            sourceID = (-1) * sourceID
            guard
                  let source = try? Realm().objects(Groups.self).filter("id == %@", sourceID),
                  let group = source.first
            else {return}
            photoURL = group.icon
            author = group.name
        }
        feedAuthorImage.kf.setImage(with:URL(string: photoURL))
        feedAuthor.text = author
        feedAuthorTime.text = dateFormatter.string(from: date)
    }
}

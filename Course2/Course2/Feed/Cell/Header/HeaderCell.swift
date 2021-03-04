//
//  HeaderCell.swift
//  Course2
//
//  Created by N!kS on 03.03.2021.
//

import UIKit

class HeaderCell: UITableViewCell {
    static let reuseIdentifier = String(describing: self)
    static var nib: UINib {
        return UINib(nibName: String(describing: self),
                     bundle: nil)
    }
    @IBOutlet weak var feedAuthor: UILabel!
    @IBOutlet weak var feedAuthorImage : FriendAvatarImageView!
    @IBOutlet weak var feedAuthorTime : UILabel!
    @IBOutlet weak var feedText : UILabel!

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
        self.feedText.text = nil
    }
    func configure(with feed: Feed) {
        self.feedAuthor.text = "GKB"
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        let date = Date(timeIntervalSince1970: TimeInterval(feed.authorDate))
        self.feedAuthorTime.text = dateFormatter.string(from: date)
        self.feedAuthorImage.image = UIImage(named: "avatar")
        self.feedText.text = feed.text
        print("success w1")
    }
    
    
    
}

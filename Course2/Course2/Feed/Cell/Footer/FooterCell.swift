//
//  FooterCell.swift
//  Course2
//
//  Created by N!kS on 03.03.2021.
//

import UIKit

class FooterCell: UITableViewCell {
    static var reuseIdentifier: String { String(describing: self) }
    static var nib: UINib {
        return UINib(nibName: String(describing: self),
                     bundle: nil)
        
    }
    
    @IBOutlet weak var likesControl: LikeControl!
    @IBOutlet weak var sharesButton: UIButton!
    @IBOutlet weak var commentsButton: UIButton!
    
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
        self.likesControl.likeCount = 0
        self.commentsButton.setTitle("0", for: .normal)
        self.sharesButton.setTitle("0", for: .normal)
    }
    
    func configure(with feed: Feed) {
        self.likesControl.likeCount = feed.likesCount
        feed.postIsLiked != 0 ? (self.likesControl.isLiked = true) : (self.likesControl.isLiked = false)
        self.commentsButton.setTitle("\(feed.commentsCount)", for: .normal)
        self.sharesButton.setTitle("\(feed.sharesCount)", for: .normal)
    }
}

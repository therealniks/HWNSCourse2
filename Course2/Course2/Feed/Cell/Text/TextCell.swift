//
//  TextCell.swift
//  Course2
//
//  Created by N!kS on 21.03.2021.
//

import UIKit

class TextCell: UITableViewCell {
    static var reuseIdentifier: String { String(describing: self) }
    static var nib: UINib {
        return UINib(nibName: String(describing: self),
                     bundle: nil)
    }
    @IBOutlet weak var feedText : UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.feedText.text = nil
    }
    
    
    func configure(with feed: Feed) {
        self.feedText.text = feed.text
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

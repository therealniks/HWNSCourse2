//
//  TextCell.swift
//  Course2
//
//  Created by N!kS on 21.03.2021.
//

import UIKit

protocol AnyTextCell: AnyObject {
    func textCellTapped(at indexPath: IndexPath)
}

class TextCell: UITableViewCell {
    static var reuseIdentifier: String { String(describing: self) }
    static var nib: UINib {
        return UINib(nibName: String(describing: self),
                     bundle: nil)
    }
    @IBOutlet weak var feedText : UILabel!
    
    
    weak var delegate: AnyTextCell?
    var indexPath = IndexPath()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.feedText.text = nil
    }
    
    
    func configure(with feed: Feed, indexPath: IndexPath) {
        self.indexPath = indexPath
        self.feedText.text = feed.text
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGR.numberOfTapsRequired = 2
        contentView.addGestureRecognizer(tapGR)
    }

    @objc
    private func tapped() {
        delegate?.textCellTapped(at: indexPath)
    }
}

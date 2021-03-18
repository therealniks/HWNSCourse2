//
//  BodyCell.swift
//  Course2
//
//  Created by N!kS on 03.03.2021.
//

import UIKit
import Kingfisher

class BodyCell: UITableViewCell {
    static var reuseIdentifier: String { String(describing: self) }
    static var nib: UINib {
        return UINib(nibName: String(describing: self),
                     bundle: nil)
        
    }
    
    @IBOutlet weak var feedImage: UIImageView!
    
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
        self.feedImage.image = nil
    }
 
    func configure(with photo: Photo?, by photoService:PhotoService) {
        guard let photo = photo else {return}
        let url = photo.photo
        photoService.photo(url: url) {[weak self] image in
                    self?.feedImage.image = image
                }
            }
    
    
    }
    


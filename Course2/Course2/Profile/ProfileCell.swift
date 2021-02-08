//
//  ProfileCell.swift
//  Course2
//
//  Created by N!kS on 09.12.2020.
//

import UIKit

class ProfileCell: UICollectionViewCell {

    @IBOutlet weak var image: ScaleImage!
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
    }

    

    
    func downloadImage(imageURL: URL?) {
        guard let imageURL = imageURL else { return }
        DispatchQueue.global().async {
            do {
                let imageData = try Data(contentsOf: imageURL)
                DispatchQueue.main.sync {
                    self.image.image = UIImage(data: imageData)
                }
            } catch {
                print(error)
            }
        }
        
    }
}


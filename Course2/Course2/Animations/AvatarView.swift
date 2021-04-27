//
//  AvatarView.swift
//  Course2
//
//  Created by N!kS on 15.12.2020.
//

import UIKit

class AvatarView: UIImageView {
    @IBInspectable var shadowColor: UIColor = .lightGray
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0)
    @IBInspectable var shadowOpacity: Float = 0.8
    @IBInspectable var shadowRadius: CGFloat = 3
    let photoImage = UIImageView()
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImage.layer.cornerRadius = self.frame.height/2
        photoImage.layer.masksToBounds = true
        self.backgroundColor = .clear
        photoImage.removeFromSuperview()
        addSubview(photoImage)
        photoImage.frame = bounds
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
    }
}
    class FriendAvatarImageView: UIImageView{
        override func layoutSubviews() {
            super.layoutSubviews()
            layer.cornerRadius = bounds.height / 2
        }
        
    }

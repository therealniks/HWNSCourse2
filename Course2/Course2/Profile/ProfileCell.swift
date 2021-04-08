//
//  ProfileCell.swift
//  Course2
//
//  Created by N!kS on 09.12.2020.
//

import UIKit

class ProfileCell: UICollectionViewCell {

    var friendPhotoImageView : UIImageView  = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView 
    }()
    
    var likeControl =  LikeControl()
    override func prepareForReuse() {
        super.prepareForReuse()
        friendPhotoImageView.image = nil
        setNeedsLayout()
    }
    let intsets:CGFloat = 20.0
    func getImageSize()-> CGSize{
        return CGSize(width: bounds.width, height: 450.0)
    }
    func getLikeControlSize()->CGSize{
        return CGSize(width: 100.0, height: 50.0)
    }
    func imageFrame(){
        let imageSize = getImageSize()
        let imageX = (bounds.width - imageSize.width)/2
        let imageY = (bounds.height - imageSize.height)/2 - 3*intsets
        let imageOrigin = CGPoint(x: imageX, y: imageY)
        friendPhotoImageView.frame = CGRect(origin: imageOrigin, size: imageSize)
    }
    func likeControlFrame(){
        let likeControlSize = getLikeControlSize()
        let imageSize = getImageSize()
        let likeControlX = (bounds.width - likeControlSize.width)/2
        let likeControlY = (imageSize.height + intsets)
        let likeControlOrigin = CGPoint(x: likeControlX, y: likeControlY)
        likeControl.frame = CGRect(origin: likeControlOrigin, size: likeControlSize)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageFrame()
        likeControlFrame()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    func setupSubviews(){
        addSubview(friendPhotoImageView)
        addSubview(likeControl)
    }
    
    func configure(with photo:Photo?){
        guard let photo = photo else {return}
        let url = URL(string: photo.url)
        friendPhotoImageView.kf.setImage(with: url)
        likeControl.likeCount = photo.likes
    }
    

    
    func downloadImage(imageURL: URL?) {
        guard let imageURL = imageURL else { return }
            do {
                let imageData = try Data(contentsOf: imageURL)
                DispatchQueue.main.sync {
                    self.friendPhotoImageView.image = UIImage(data: imageData)
                }
            } catch {
                print(error)
            }
    }
}


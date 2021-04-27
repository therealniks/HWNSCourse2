//
//  LikedControl.swift
//  Course2
//
//  Created by N!kS on 19.12.2020.
//

import UIKit
@IBDesignable class LikeControl: UIControl {
    
    var likeCount: Int = 0{
        didSet{
            likeButton.setTitle("\(likeCount)", for: .normal)
        }
    }
    var isLiked: Bool = false {
        didSet {
            likeButton.setImage(isLiked ? self.likedImage : self.unlikedImage, for: .normal)
        }
    }
    var likeButton = UIButton(type: .custom)
    private var likedImage = UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal) 
    private var unlikedImage = UIImage(systemName: "heart")?.withTintColor(.black, renderingMode: .alwaysTemplate)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    private func setupView() {
        likeButton.imageView?.contentMode = .scaleAspectFill
        likeButton.setTitleColor(.red, for: .normal)
        likeButton.tintColor = .red
        likeButton.setTitle("\(likeCount)", for: .normal)
        likeButton.setImage(unlikedImage, for: .normal)
        likeButton.addTarget(self, action: #selector(pushLikeButton(_ :)), for: .touchUpInside)
        self.addSubview(likeButton)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        likeButton.frame = bounds
    }
    @objc
    private func pushLikeButton(_ sender: UIButton)
    {
        isLiked.toggle()
        likeCount = isLiked ? (likeCount + 1) : (likeCount - 1)

        animate()
        self.sendActions(for: .valueChanged)
    }
 
    private func animate(){
        UIView.animate(withDuration: 0.1, animations: {
            let newImage = self.isLiked ? self.likedImage : self.unlikedImage
            let newScale = self.isLiked ? self.likedImage?.scale : self.unlikedImage?.scale
            self.likeButton.transform = self.transform.scaledBy(x: newScale!, y: newScale!)
            self.likeButton.setImage(newImage, for: .normal)
        }, completion: {_ in
            UIView.animate(withDuration: 0.1, animations: {
                self.likeButton.transform = CGAffineTransform.identity
                })
            })
    }
}

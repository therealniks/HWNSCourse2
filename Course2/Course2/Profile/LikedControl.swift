//
//  LikedControl.swift
//  Course2
//
//  Created by N!kS on 19.12.2020.
//

import UIKit
enum liked{
    case liked
    case unliked
}

@IBDesignable class LikedControl: UIControl {
    var likeCount: UInt = 0
    var selectedLike: liked? = nil {
        didSet {
            self.updatesLike()
            self.sendActions(for: .valueChanged)
        }
    }
    
    private var likeButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    private func setupView() {

        likeButton = UIButton(type: .system)
        likeButton.setTitle("Unliked", for: .normal)
        likeButton.setTitleColor(.lightGray, for: .normal)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setTitleColor(.white, for: .selected)
        likeButton.setImage(UIImage(systemName: "heart_fill"), for: .selected)
        likeButton.addTarget(self, action: #selector(golike(_:)), for: .touchUpInside)
        self.addSubview(likeButton)

    }
    
    private func updatesLike() {
        likeButton.isSelected = selectedLike == .liked
        }
    
    
 @objc
    private func golike(_ sender: UIButton) {
        selectedLike = .liked
        likeCount+=1
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
}

    
    
    
    
    




    
    

    
    

   



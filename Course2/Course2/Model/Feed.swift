//
//  Feed.swift
//  Course2
//
//  Created by N!kS on 20.12.2020.
//

import UIKit
class Feed{
    var feedText: String
    var feedCommentCount: UInt
    var feedShareCount :UInt
    var feedLikeCount: UInt
    var feedLogo : UIImageView
    
    init(feedText: String,feedCommentCount: UInt,feedShareCount :UInt,
        feedLikeCount: UInt, feedLogo : UIImage) {
        self.feedText = feedText
        self.feedCommentCount = feedCommentCount
        self.feedShareCount = feedShareCount
        self.feedLikeCount = feedLikeCount
        self.feedLogo = UIImageView.init(image: UIImage(named: "avatar")!)
    }
}

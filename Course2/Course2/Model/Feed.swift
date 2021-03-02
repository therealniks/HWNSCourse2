//
//  Feed.swift
//  Course2
//
//  Created by N!kS on 20.12.2020.
//

import UIKit
class Feed{
    var feedText: String
    var feedAuthorImage : UIImage
    var feedAuthor : String
    var feedAuthorTime: String
    var feedCommentCount: UInt
    var feedShareCount :UInt
    var feedLikeCount: UInt
    var feedLogo : UIImage
    init(feedText: String,feedCommentCount: UInt,feedShareCount :UInt,
        feedLikeCount: UInt, feedLogo : UIImage) {
        self.feedText = feedText
        self.feedCommentCount = feedCommentCount
        self.feedShareCount = feedShareCount
        self.feedLikeCount = feedLikeCount
        self.feedLogo = UIImage(named: "avatar")!
        self.feedAuthorImage = UIImage(named: "avatar")!
        self.feedAuthor = "VkNews"
        self.feedAuthorTime = "2 марта 23:14"
    }
}

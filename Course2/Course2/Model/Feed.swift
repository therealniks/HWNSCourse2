//
//  Feed.swift
//  Course2
//
//  Created by N!kS on 20.12.2020.
//

import UIKit
import SwiftyJSON
class Feed {
        //var authorImage : UIImage
       // var author : String
        var authorDate: Double
        var type : String
        var postId : Double
        var text: String
        var likesCount : Int
        var sharesCount : Int
        var commentsCount : Int
        init(_ json: JSON) {
            self.authorDate = json["date"].doubleValue
            self.text = json["text"].stringValue
            self.type = json["type"].stringValue
            self.postId = json["post_id"].doubleValue
            self.likesCount = json["likes"]["count"].intValue
            self.sharesCount = json["reposts"]["count"].intValue
            self.commentsCount = json["comments"]["count"].intValue
        }
}
            

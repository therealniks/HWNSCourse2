//
//  Feed.swift
//  Course2
//
//  Created by N!kS on 20.12.2020.
//

import UIKit
import SwiftyJSON
import RealmSwift
class Feed : Object {
    @objc dynamic var authorDate: Double = 0
    var type : String = ""
    @objc dynamic var postID : Int = 0
    @objc dynamic var text: String = ""
    @objc dynamic var likesCount : Int = 0
    @objc dynamic var sharesCount : Int = 0
    @objc dynamic var commentsCount : Int = 0
    @objc dynamic var postIsLiked: Int = 0
    @objc dynamic var sourceID : Int = 0
    var array = [JSON]()
    var feedPhotoURL : String = ""
    
        convenience init(_ json: JSON) {
            self.init()
            self.authorDate = json["date"].doubleValue
            self.text = json["text"].stringValue
            self.type = json["type"].stringValue
            self.likesCount = json["likes"]["count"].intValue
            self.postIsLiked = json ["likes"]["user_likes"].intValue
            self.sharesCount = json["reposts"]["count"].intValue
            self.commentsCount = json["comments"]["count"].intValue
            self.sourceID = json["source_id"].intValue
            self.postID = json["post_id"].intValue
            self.type = json["attachments"]["type"].stringValue
            if type == "photo"{
                let photoArray = json["attachments"].arrayValue
                feedPhotoURL = photoArray[0]["photo"]["photo_604"].stringValue
                
            }
            
        }
        
    
    override static func primaryKey()-> String? {
        return "postID"
    }
}

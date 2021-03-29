//
//  Feed.swift
//  Course2
//
//  Created by N!kS on 20.12.2020.
//

import UIKit
import SwiftyJSON
class Feed {
    var authorDate: Double
    var type : String
    var postID : Int
    var text: String
    var likesCount : Int
    var sharesCount : Int
    var commentsCount : Int
    var postIsLiked: Int
    var sourceID : Int
    var array = [JSON]()
    var feedPhotoURL : String = ""
    var widthPhoto: Int?
    var heightPhoto: Int?
    var aspectRatio: CGFloat {
        guard
            let widthPhoto = widthPhoto,
            let heightPhoto = heightPhoto,
            heightPhoto != 0
        else { return 0 }
        return CGFloat(heightPhoto)/CGFloat(widthPhoto)
    }
    
        init(_ json: JSON) {
            self.authorDate = json["date"].doubleValue
            self.text = json["text"].stringValue
            self.type = json["type"].stringValue
            self.likesCount = json["likes"]["count"].intValue
            self.postIsLiked = json ["likes"]["user_likes"].intValue
            self.sharesCount = json["reposts"]["count"].intValue
            self.commentsCount = json["comments"]["count"].intValue
            self.sourceID = json["source_id"].intValue
            self.postID = json["post_id"].intValue
            if type == "post"{
                let attachment = json["attachments"][0]
                let attachmentType = attachment["type"]
                switch attachmentType {
                case "photo":
                    let photoSizes = attachment["photo"]["sizes"].arrayValue
                    guard
                        let photoSizeX = photoSizes.first(where:{ $0["height"].intValue >= 600 })
                    else {
                        print("Error")
                        return }
                    feedPhotoURL = photoSizeX["url"].stringValue
                    widthPhoto = photoSizeX["width"].intValue
                    heightPhoto = photoSizeX["height"].intValue
                default:
                    feedPhotoURL = ""
                }

            }
            
        }
}

//
//  Photos.swift
//  Course2
//
//  Created by N!kS on 23.01.2021.
//

import Foundation
import SwiftyJSON
import RealmSwift
class Photos: Object {
   @objc dynamic var url: String = ""
    var someURL: URL?
    var likes : Int = 0

    convenience init(_ json: JSON) {
        self.init()
        let sizes = json["sizes"].arrayValue
        let biggestSize = sizes.reduce(sizes[0]) { currentTopSize, newSize -> JSON in
            let currentPoints = currentTopSize["width"].intValue * currentTopSize["height"].intValue
            let newSizePoints = newSize["width"].intValue * newSize["height"].intValue
            return currentPoints >= newSizePoints ? currentTopSize : newSize
        }
        print(biggestSize)

        self.url = biggestSize["url"].stringValue
        self.likes = json["likes"]["count"].intValue
        print("likes %- \(likes)")
        self.someURL = URL(string: biggestSize["url"].stringValue)
        
        let owners = LinkingObjects(fromType : Friends.self , property : "photos")
    
//    override static func primaryKey()-> String? {
//        return "url"
//        }
    }
}



//
//  Photos.swift
//  Course2
//
//  Created by N!kS on 23.01.2021.
//

import RealmSwift
import SwiftyJSON
class Photos: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var ownerID: Int = 0
    @objc dynamic var url: String = ""
    @objc dynamic var likes: Int = 0
    var someURL: URL?

    
    let owners = LinkingObjects(fromType : Friends.self , property : "photos")
    
    convenience init(_ json: JSON, _ ownerID: Int) {
        self.init()
        let sizes = json["sizes"].arrayValue
        let biggestSize = sizes.reduce(sizes[0]) { currentTopSize, newSize -> JSON in
            let currentPoints = currentTopSize["width"].intValue * currentTopSize["height"].intValue
            let newSizePoints = newSize["width"].intValue * newSize["height"].intValue
            return currentPoints >= newSizePoints ? currentTopSize : newSize
        }
        print(biggestSize)
        self.ownerID = ownerID
        self.url = biggestSize["url"].stringValue
        self.likes = json["likes"]["count"].intValue
        self.someURL = URL(string: biggestSize["url"].stringValue)
    }
    
    override static func primaryKey()-> String? {
        return "id"
    }
}



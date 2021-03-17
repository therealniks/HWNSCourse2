//
//  Groups.swift
//  Course2
//
//  Created by N!kS on 21.01.2021.
//

import RealmSwift
import SwiftyJSON



class Groups : Object{
    @objc dynamic var name: String = ""
    @objc dynamic var icon: String = ""
    @objc dynamic var id : Int = 0
    convenience init(_ json: JSON) {
        self.init()
        self.name = json["name"].stringValue
        self.icon = json["photo_100"].stringValue
        self.id = json["id"].intValue
    }
    
    override static func primaryKey()-> String? {
        return "id"
    }
}

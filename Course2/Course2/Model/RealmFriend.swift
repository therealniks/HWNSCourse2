//
//  Friends.swift
//  Course2
//
//  Created by N!kS on 20.01.2021.
//

import SwiftyJSON
import RealmSwift

class RealmFriend: Object {
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName : String = ""
    @objc dynamic var id : Int = 0
    @objc dynamic var icon: String = ""
    convenience init(_ json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.icon = json["photo_100"].stringValue
    }
    let photos = List<RealmPhoto>()
    override static func primaryKey()-> String? {
        return "id"
    }
}

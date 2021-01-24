//
//  Friends.swift
//  Course2
//
//  Created by N!kS on 20.01.2021.
//

import Foundation
import SwiftyJSON

struct Friends {
    let firstName: String
    var lastName : String
    let id : UInt64
    let icon: String
    init(_ json: JSON) {
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.id = json["id"].uInt64Value
        self.icon = json["photo_100"].stringValue
    }    
}

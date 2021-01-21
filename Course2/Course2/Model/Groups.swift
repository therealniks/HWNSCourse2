//
//  Groups.swift
//  Course2
//
//  Created by N!kS on 21.01.2021.
//

import Foundation
import SwiftyJSON


struct Groups {
    let name: String
    let icon: String
    init(_ json: JSON) {
        self.name = json["name"].stringValue
        self.icon = json["photo_100"].stringValue    
}
}

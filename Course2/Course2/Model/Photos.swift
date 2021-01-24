//
//  Photos.swift
//  Course2
//
//  Created by N!kS on 23.01.2021.
//

import Foundation
import SwiftyJSON
struct Photos{
    var url: String
    init(_ json: JSON) {
        self.url = json["sizes"]["url"].stringValue
    }
}

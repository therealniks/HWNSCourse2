//
//  File.swift
//  Course2
//
//  Created by N!kS on 20.12.2020.
//

import UIKit
class Group{
    let id: UInt32
    var title: String
    var description: String
    var avatar : UIImage
    init(id: UInt32, title: String, description: String) {
        self.id = id
        self.title = title
        self.description = description
        self.avatar = UIImage(named: "avatar")!
    }
}

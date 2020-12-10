//
//  File.swift
//  Course2
//
//  Created by N!kS on 09.12.2020.
//
import UIKit
class User{
    var id: UInt32
    var name: String
    var surname: String
    var avatar : UIImage
    init(id: UInt32, name: String, surname: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.avatar = UIImage(named: "avatar")!
    }
}

class Group{
    var id: UInt32
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

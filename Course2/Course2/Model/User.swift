//
//  File.swift
//  Course2
//
//  Created by N!kS on 09.12.2020.
//
import UIKit

class User{
    let id: UInt32
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


//
//  FireBaseMyGroups.swift
//  Course2
//
//  Created by N!kS on 10.02.2021.
//

import Firebase
import Foundation

class FireBaseMyGroups{
    let name : String
    let iconURL: String
    let ref: DatabaseReference?
    init(name: String, iconURL: String){
        self.name = name
        self.iconURL = iconURL
        self.ref = nil
    }
    init?(snapshot:DataSnapshot){
        guard
            let value = snapshot.value as? [String:Any],
            let name = value["name"] as? String,
            let iconURL = value["iconURL"] as? String
        else {return nil}
        self.ref = snapshot.ref
        self.name = name
        self.iconURL = iconURL
    }
    func toAnyObject() -> [String:Any] {
        return [
            "name" : name,
            "iconURL": iconURL
        ]
    }
}

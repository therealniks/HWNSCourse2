//
//  UserSession.swift
//  Course2
//
//  Created by N!kS on 13.01.2021.
//

import UIKit

class UserSession{
    static let instance = UserSession()
    private init(){}
    var token = ""
    var id: UInt = 0
    
}

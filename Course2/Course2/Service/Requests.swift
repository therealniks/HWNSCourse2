//
//  Requests.swift
//  Course2
//
//  Created by N!kS on 18.01.2021.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

    let realm = try! Realm()
    private let host = "https://api.vk.com"
    func getFriends(for id: Int, completion: @escaping ()->Void){
        let path = "/method/friends.get"
        let parametrs : Parameters = [
            "user_id" : UserSession.instance.id,
            "access_token": UserSession.instance.token,
            "v" : "5.126",
            "fields" : "photo_100",
            "extended" : 1
        ]
        
        AF.request(host + path,
                   method: .get,
                   parameters: parametrs)
                    .responseData { response in
                        switch response.result {
                        case .success(let data):
                            let json = JSON(data)
                            let friendsJSONs = json["response"]["items"].arrayValue
                            let myFriends = friendsJSONs.compactMap { Friends($0) }
                            try? RealmProvider.save(items: myFriends)
                            completion()
                        case .failure(let error):
                            print(error)
            }
        
    }
 }
        
        
    
   func getGroups(for id: Int, completion: @escaping ()->Void){
        let path = "/method/groups.get"
        let parametrs : Parameters = [
            "user_id" :     UserSession.instance.id,
            "access_token": UserSession.instance.token,
            "v"       :     "5.126",
            "extended"  :     "1"
        ]
        AF.request(host + path,
                   method: .get,
                   parameters: parametrs)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let friendsJSONs = json["response"]["items"].arrayValue
                    let myGroups = friendsJSONs.compactMap { Groups($0) }
                    try? RealmProvider.save(items: myGroups)
                    completion()
                case .failure(let error):
                    print(error)
    }
            }
   }
    
 func getPhotos(for id: Int){
        let path = "/method/photos.getAll"
        let parametrs : Parameters = [
            "owner_id" :     id,
            "access_token": UserSession.instance.token,
            "v"       :     "5.126",
            "extended" : 1
        ]
        AF.request(host + path,
                   method: .get,
                   parameters: parametrs)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let photosJSONs = json["response"]["items"].arrayValue
                    let photos = photosJSONs.compactMap { Photos($0, id) }
                    try? RealmProvider.save(items: photos)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    


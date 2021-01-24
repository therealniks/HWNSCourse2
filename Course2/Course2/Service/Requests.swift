//
//  Requests.swift
//  Course2
//
//  Created by N!kS on 18.01.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class Requests {
    private let host = "https://api.vk.com"
    func getFriends(for id: UInt, completion: @escaping ([Friends])->Void){
        let path = "/method/friends.get"
        let parametrs : Parameters = [
            "user_id" :     UserSession.instance.id,
            "access_token": UserSession.instance.token,
            "v"       :     "5.126",
            "fields"  :     "photo_100"
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
                            completion(myFriends)
                        case .failure(let error):
                            print(error)
            }
        
    }
 }
        
        
    
   func getGroups(for id: UInt, completion: @escaping ([Groups])->Void){
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
                    completion(myGroups)
                case .failure(let error):
                    print(error)
    }
            }
   }
    
 func getPhotos(for id: UInt64, completion: @escaping ([Photos])->Void){
        let path = "/method/photos.getAll"
        let parametrs : Parameters = [
            "owner_id" :     UserSession.instance.id,
            "access_token": UserSession.instance.token,
            "v"       :     "5.126"
        ]
        
        AF.request(host + path,
                   method: .get,
                   parameters: parametrs)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let photosJSONs = json["response"]["items"].arrayValue
                    let usersPhotos = photosJSONs.compactMap { Photos($0) }
                    completion(usersPhotos)
                    print(usersPhotos.count)
                case .failure(let error):
                    print(error)
                }
            }
    }
}

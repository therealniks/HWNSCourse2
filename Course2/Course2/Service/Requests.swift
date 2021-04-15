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
class NetworkService{
    var realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded : true))
    private let host = "https://api.vk.com"
    
    func getFriends(for id: Int, completion: @escaping ([RealmFriend])->Void){
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
                            let myFriends = friendsJSONs.compactMap { RealmFriend($0) }
                            DispatchQueue.main.async{
                                completion(myFriends)
                                try? RealmProvider.save(items: myFriends)
                            }
                        case .failure(let error):
                            print(error)
            }
        
    }
 }
        
        
    
   func getGroups(for id: Int, completion: @escaping ([Groups])->Void){
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
                    DispatchQueue.main.async{
                        completion(myGroups)
                        try? RealmProvider.save(items: myGroups)
                    }
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
                    let photos = photosJSONs.compactMap { RealmPhoto($0, ownerID: id) }
                    try? RealmProvider.save(items: photos)
                case .failure(let error):
                    print(error)
                }
            }
    }

func getFeed(
    startTime: Double? = nil,
    startFrom: String? = nil,
    _ completion: @escaping ([Feed], [RealmFriend], [Groups], String) -> Void){
    let path = "/method/newsfeed.get"
    var parametrs : Parameters = [
        "v" : "5.126",
        "access_token": UserSession.instance.token,
        "filter" : "posts",
        "count" : "10"
    ]
    if let startTime = startTime {
        parametrs["start_time"] = startTime
    }
    
    if let startFrom = startFrom {
        parametrs["start_from"] = startFrom
    }
    
    
    AF.request(host + path,
               method: .get,
               parameters: parametrs)
        .responseData{response in
            switch response.result{
            case .success(let data):
                let json = JSON(data)
                let newsJSON = json["response"]["items"].arrayValue
                let newsProfileJSON = json["response"]["profiles"].arrayValue
                let newsGroupsJSON = json["response"]["groups"].arrayValue
                let nextFrom = json["response"]["next_from"].stringValue
                let feed = newsJSON.compactMap{Feed($0)}
                let newsProfiles = newsProfileJSON.compactMap{RealmFriend($0)}
                let newsGroups = newsGroupsJSON.compactMap{Groups($0)}
                DispatchQueue.main.async {
                    completion(feed, newsProfiles, newsGroups, nextFrom)
                }
                
            case .failure(let error):
                print(error)
            }
        }
}
}
    


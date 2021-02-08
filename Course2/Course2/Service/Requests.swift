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

class Requests {
    private let host = "https://api.vk.com"
    //let config = Realm.Configuration(deleteRealmIfMigrationNeeded : true)
    public let realm = try! Realm(configuration : Realm.Configuration(deleteRealmIfMigrationNeeded : true))
    
    
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
                            self.saveFriendsData(for: id, myFriends)
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
                    self.saveGroupsData(for: id, myGroups)
                    completion()
                case .failure(let error):
                    print(error)
    }
            }
   }
    
 func getPhotos(for id: Int, completion: @escaping ()->Void){
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
                    let photos = photosJSONs.compactMap { Photos($0) }
                    self.savePhotosData(for: id, photos)
                    completion()
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    private func saveFriendsData (for id: Int, _ friends: [Friends]){
        do {
                realm.beginWrite()
            realm.add(friends, update: .modified)
            try realm.commitWrite()
                print(realm.configuration.fileURL!)
            }catch {
                print (error.localizedDescription)
            }
        
    }

    
    private func saveGroupsData(for id: Int, _ groups: [Groups]){
        do{
            realm.beginWrite()
            realm.add(groups, update: .modified)
            try realm.commitWrite()
        } catch{
            print(error.localizedDescription)
        }
        
    }
    
    
    private func savePhotosData(for id: Int, _ photos: [Photos]){
        do{
            realm.beginWrite()
            realm.add(photos)
            try realm.commitWrite()
        } catch{
            print(error.localizedDescription)
        }
        
    }
    
    
}

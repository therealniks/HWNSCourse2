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
                            //print(json)
                            let friendsJSONs = json["response"]["items"].arrayValue
                            let myFriends = friendsJSONs.compactMap { Friends($0) }
                            completion(myFriends)
                        case .failure(let error):
                            print(error)
            }
        
    }
 }
//        let configuration = URLSessionConfiguration.default
//        let session = URLSession(configuration: configuration)
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.vk.com"
//        urlComponents.path = "/method/friends.get"
//        urlComponents.queryItems=[
//            URLQueryItem.init(name: "user_id", value: UserSession.instance.token),
//            URLQueryItem(name: "access_token", value: UserSession.instance.token),
//            URLQueryItem(name: "v", value: "5.126"),
//            URLQueryItem(name: "fields", value: "city"),
//        ]
//
//        let request = URLRequest(url: urlComponents.url!)
//        let task = session.dataTask (with : request )
//        { ( data , response , error ) in
//        let json = try? JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.allowFragments)
//        print(json ?? "false")
//        }
//        task.resume()
        
    
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
                    //print(json)
                    let friendsJSONs = json["response"]["items"].arrayValue
                    let myGroups = friendsJSONs.compactMap { Groups($0) }
                    completion(myGroups)
                case .failure(let error):
                    print(error)
    }
            }
   }
    
 func getPhotos(){
        let path = "/method/photos.getAll"
        let parametrs : Parameters = [
            "owner_id" :     UserSession.instance.id,
            "access_token": UserSession.instance.token,
            "v"       :     "5.126",
            "fields"  :     "city"
        ]
        
        AF.request(host + path,
                   method: .get,
                   parameters: parametrs)
           .responseJSON { json in
               print(json)
            }
    }
}

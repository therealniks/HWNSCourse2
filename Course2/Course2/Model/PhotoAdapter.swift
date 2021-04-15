//
//  PhotoAdapter.swift
//  Course2
//
//  Created by N!kS on 14.04.2021.
//

import Foundation
import RealmSwift


class PhotoAdapter {
    private let networkService = NetworkService()
    private let realmNotificationTokens: [String:NotificationToken] = [:]
    
    func getPhotos(for id: Int, then complition: @escaping ([Photo])->Void) {
        guard let realmPhotos = try? RealmProvider.get(RealmPhoto.self)
        else { return }
 
        realmPhotos.observe{ [weak self]
            (changes: RealmCollectionChange) in
            guard let self = self else { return }
            switch changes {
            case .initial(let realmPhotos), .update(let realmPhotos, _, _, _):
                var userPhotos = [Photo]()
                realmPhotos.forEach {
                    userPhotos.append(self.adapt(from: $0))
                }
            complition(userPhotos)
            case .error(let error):
                print(error)
            }
        }
        networkService.getPhotos(for: id)
    }
     
    
    private func adapt(from realmPhoto: RealmPhoto)-> Photo {
        Photo(likes: realmPhoto.likes, someURL: realmPhoto.someURL, ownerID: realmPhoto.ownerID)
    }
        
}


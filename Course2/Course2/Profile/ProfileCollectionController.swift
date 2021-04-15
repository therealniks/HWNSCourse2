//
//  ProfileCollectionController.swift
//  Course2
//
//  Created by N!kS on 09.12.2020.
//

import UIKit
import Kingfisher
import RealmSwift

private let reuseIdentifier = "Cell"
var photoAdapter = PhotoAdapter()

class ProfileCollectionController: UICollectionViewController {
    
    var usersPhotos: [Photo]?
    var notificationToken: NotificationToken?
    var id : Int = 0
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        usersPhotos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath)
            as? ProfileCell
        guard let userPhoto = usersPhotos?[indexPath.row] else { return UICollectionViewCell() }
        cell?.configure(with: userPhoto)
        return cell!
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoAdapter.getPhotos(for: id){ [weak self] photos in
            self?.usersPhotos = photos
            print(photos.count)
            self?.collectionView.reloadData()
        }
    }
}


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
var networkService = NetworkService()
class ProfileCollectionController: UICollectionViewController {
    
    var usersPhotos: Results<Photos>?
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
        cell?.image.kf.setImage(with: URL(string: userPhoto.url))
        cell?.likeControl.likeCount = userPhoto.likes
        print("opa \( userPhoto.likes)")
        return cell!
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.getPhotos(for: id)
        maketUserPhotos()
            
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        makeNotificationToken()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        notificationToken?.invalidate()
    }
    
    private func maketUserPhotos() {
        do {
            usersPhotos = try RealmProvider
                .get(Photos.self)
                .filter("ownerID == %@", id)
        } catch {
            print(error)
        }
    }
    
    private func makeNotificationToken() {
        notificationToken = usersPhotos?.observe({ [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial:
                self.collectionView.reloadData()
            case .update:
                self.collectionView.reloadData()
            case .error(let error):
                print(error)
            }
        })
    }
}

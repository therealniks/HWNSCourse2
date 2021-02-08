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

class ProfileCollectionController: UICollectionViewController {

    var usersPhotos = [Photos]()
    var id : Int = 0
    var likeControl = LikeControl()
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    
    
    

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        usersPhotos.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath)
        as? ProfileCell
        cell?.image.kf.setImage(with: URL(string:usersPhotos[indexPath.row].url ))
        likeControl.likeCount = usersPhotos[indexPath.row].likes
        print("opa \( usersPhotos[indexPath.row].likes)")
        return cell!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let userPhotos = Requests()
        userPhotos.getPhotos(for: id) {
            [weak self] in
            self?.loadPhotosData()
            self?.collectionView.reloadData()
            
        }
        
    }
    
    
}
    
    extension ProfileCollectionController{
        private func loadPhotosData(){
            do {
                let realm = try Realm()
                let photos = realm.objects(Photos.self)
                self.usersPhotos = Array(photos)
                }catch{
                    print ( error.localizedDescription)
                }
        }
        

        
        
    
    
    
    


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}


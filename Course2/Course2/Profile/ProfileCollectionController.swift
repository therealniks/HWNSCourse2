//
//  ProfileCollectionController.swift
//  Course2
//
//  Created by N!kS on 09.12.2020.
//

import UIKit

private let reuseIdentifier = "Cell"

class ProfileCollectionController: UICollectionViewController {


    
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
        5
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath)
        as? ProfileCell
        cell?.image.image = UIImage(named: "avatar")!
        return cell!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems=[
            URLQueryItem.init(name: "owner_id", value: "71613812"),
            URLQueryItem(name: "access_token", value: UserSession.instance.token),
            URLQueryItem(name: "v", value: "5.126"),
            URLQueryItem(name: "extended", value: "1"),
        ]
        let request = URLRequest(url: urlComponents.url!)
        let task = session.dataTask (with : request )
        {(data , response , error ) in
        let json = try? JSONSerialization.jsonObject(with: data!,
                        options:JSONSerialization.ReadingOptions.allowFragments)
        print(json ?? "false")
        }
        task.resume()
        
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


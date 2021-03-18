//
//  PhotoService.swift
//  Course2
//
//  Created by N!kS on 17.03.2021.
//

import UIKit
import Alamofire

class PhotoService{
    
    private let cacheLifeTime: TimeInterval = 3600 * 24 * 7
    private var images = [String:UIImage]()
    private static var pathName : String = {
        let pathName = "images"
        guard
            let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else {return pathName}
        let url = cachesDirectory.appendingPathComponent(pathName,isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path){
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return pathName
    }()
    
    private func getFilePath(url:String)-> String? {
        guard
            let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else{return nil}
        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
    }
    
    private func saveImageToCache(url:String, image:UIImage){
        guard
            let fileName = getFilePath(url: url),
            let data = image.pngData()
        else{return}
        FileManager.default.createFile(atPath: fileName, contents: data)
    }
    
    private func getImageFromCache(url:String)->UIImage?{
        guard
            let fileName = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else {return nil}
        let lifeTime = Date().timeIntervalSince(modificationDate)
        guard
            lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName)
        else{return nil}
        DispatchQueue.main.async {
            self.images[url] = image
        }
        return image
    }
    
    private func loadPhoto(urlString: String, completion: @escaping (UIImage?) -> Void) {
                AF.request(urlString).responseData { [weak self] response in
                guard let self = self,
                    let data = response.data,
                    let image = UIImage(data: data) else {
                        completion(nil)
                        return
                }
                DispatchQueue.main.async { [weak self] in
                    self?.images[urlString] = image
                }
                    self.saveImageToCache(url: urlString, image: image)
                completion(image)
            }
        }
 
    public func photo(url: String, completion: @escaping (UIImage?) -> Void) {
        if let image = images[url] {
            completion(image)
        } else if let image = getImageFromCache(url: url) {
            completion(image)
        } else {
            loadPhoto(urlString: url, completion: completion)
        }
    }
    
    
    private let container: DataReloadable
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    
    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
    
    
}

fileprivate protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}

extension PhotoService {
    
    private class Table: DataReloadable {
        let table: UITableView
        
        init(table: UITableView) {
            self.table = table
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
        
    }
    
    private class Collection: DataReloadable {
        let collection: UICollectionView
        
        init(collection: UICollectionView) {
            self.collection = collection
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
    }
}

//
//  PhotoService.swift
//  Course2
//
//  Created by N!kS on 17.03.2021.
//

import UIKit

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
    
    
}

//
//  RealmProvider.swift
//  Course2
//
//  Created by N!kS on 09.02.2021.
//


import RealmSwift

class RealmProvider {
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    static func save <T: Object>(items: [T],
                                 configuration: Realm.Configuration = deleteIfMigration,
                                 update: Realm.UpdatePolicy = .modified) throws {
        let realm = try Realm(configuration: configuration)
        print(configuration.fileURL ?? "")
        try realm.write{
            realm.add(items, update: update)
        }
    }
    
    static func get <T: Object>(_ type: T.Type,
                               configuration: Realm.Configuration = deleteIfMigration) throws -> Results<T> {
        print(configuration.fileURL ?? "")
        let realm = try Realm(configuration: configuration)
        return realm.objects(type)
    }
}

//
//  Photo.swift
//  vkClient
//
//  Created by MacBook Pro on 29.12.2020.
//

import Foundation
import RealmSwift

class Photo: Object, Codable {

    @objc dynamic var id: Int = 0
    @objc dynamic var ownerId: Int = 0
    var sizes = List<Size>()//: [Size] = []
    @objc dynamic var likes: Like?

    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case sizes
        case likes
    }
    override class func primaryKey() -> String? {
        return "id"
    }

}

class Size: Object, Codable {

    @objc dynamic var url: String = ""
    @objc dynamic var width: Int = 0
    @objc dynamic var height: Int = 0
    @objc dynamic var type: String = ""
}

class Like: Object, Codable {

    @objc dynamic var isLikedByUser: Int = 0
    @objc dynamic var likesCount: Int = 0

    enum CodingKeys: String, CodingKey {
        case isLikedByUser = "user_likes"
        case likesCount = "count"
    }
}

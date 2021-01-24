//
//  Group.swift
//  vkClient
//
//  Created by MacBook Pro on 27.12.2020.
//

import Foundation
import RealmSwift

class Group: Object, Codable {

    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var avatarURL: String = ""
    @objc dynamic var isClosed: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatarURL = "photo_200"
        case isClosed = "is_closed"
    }

    override class func primaryKey() -> String? {
        return "id"
    }

}






/* deprecated
struct Group {
    let name: String
    let avatar: String

}

struct Groups {
    var groupList: [Group] = [
        Group(name: "Stark Industries", avatar: "Stark"),
        Group(name: "FBI", avatar: "FBI"),
        Group(name: "Щ.И.Т.", avatar: "Shield")
    ]
}
 */

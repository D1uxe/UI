//
//  Group.swift
//  vkClient
//
//  Created by MacBook Pro on 27.12.2020.
//

import Foundation

class Group: Codable {

    var id: Int = 0
    var name: String = ""
    var avatarURL: String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatarURL = "photo_50"
    }

    
}






/* depricated
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

//
//  Group.swift
//  vkClient
//
//  Created by MacBook Pro on 03.11.2020.
//

import Foundation

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

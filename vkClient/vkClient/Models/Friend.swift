//
//  Friend.swift
//  vkClient
//
//  Created by MacBook Pro on 03.11.2020.
//

import Foundation

struct Friend {
    let name: String
    let avatar: String
    let photo: [String]
}

struct Friends {
    var friendsList: [Friend] = [
        Friend(name: "Натали Романов", avatar: "BlackWidow", photo: ["BlackWidow1", "BlackWidow2"]),
        Friend(name: "Toni Iron Man Stark", avatar: "IronMan", photo: ["IronMan1", "IronMan2", "IronMan3", "IronMan4", "IronMan5", "IronMan6","IronMan1","IronMan3"]),
        Friend(name: "Брюс Hulk Беннер", avatar: "Hulk", photo: ["Hulk1", "Hulk2"]),
        Friend(name: "Wonder Woman", avatar: "WonderWoman", photo: ["WonderWoman1", "WonderWoman2"]),
        Friend(name: "Tanos", avatar: "Tanos", photo: ["Tanos1", "Tanos2", "Tanos3"]),
        Friend(name: "Groot", avatar: "Groot", photo: ["Groot1", "Groot2","Groot3"]),
        Friend(name: "Питер Паркер", avatar: "SpiderMan", photo: []),
        
//        Friend(name: "Supreme", avatar: "Supreme", photo: []),
//        Friend(name: "Salut", avatar: "Salut", photo: []),
//        Friend(name: "Member", avatar: "Member", photo: []),
//        Friend(name: "Memory", avatar: "Memory", photo: []),
//        Friend(name: "Got", avatar: "Groot", photo: ["Groot1", "Groot2","Groot3"]),
//        Friend(name: "Gosha", avatar: "Groot", photo: ["Groot1", "Groot2","Groot3"]),
    ]
}

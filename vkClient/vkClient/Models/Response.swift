//
//  Response.swift
//  vkClient
//
//  Created by MacBook Pro on 27.12.2020.
//

import Foundation

class Response<T>: Codable where T: Codable {
    let response: Items<T>
}


class Items<T: Codable>: Codable {
    let items: [T]
}


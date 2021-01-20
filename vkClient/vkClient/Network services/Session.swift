//
//  Session.swift
//  vkClient
//
//  Created by MacBook Pro on 16.12.2020.
//

import Foundation

class Session {

    static var shared: Session = {
        let instance = Session()

        return instance
    }()

    var token: String?
    var userId: Int?

    private init() {}
}

// запрещаем клонирование
extension Session: NSCopying {

    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}

//
//  QueryNewsProxy.swift
//  vkClient
//
//  Created by MacBook Pro on 07.04.2021.
//

import Foundation


protocol QueryNewsInterface {

    func get(startTime: String, startFrom: String?, completion: @escaping ([Post], String?) -> Void)
}


class QueryNewsProxy: QueryNewsInterface  {

    let service: QueryNews

    init(service: QueryNews) {
        self.service = service
    }

    func get(startTime: String = "", startFrom: String? = "", completion: @escaping ([Post], String?) -> Void) {

        self.service.get(startTime: startTime, startFrom: startFrom, completion: completion)
        print("\(Date()) Вызов метода \(#function) с параметрами startTime = \(startTime) startFrom = \(startFrom)")
    }

}

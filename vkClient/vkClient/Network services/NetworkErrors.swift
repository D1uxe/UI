//
//  NetWorkErrors.swift
//  vkClient
//
//  Created by MacBook Pro on 21.02.2021.
//

import Foundation

enum NetworkErrors: Error {
    case dataTaskError
    case noDataProvided
    case decodeFailed
    case badUrl
}

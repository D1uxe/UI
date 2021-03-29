//
//  ParseDataOperation.swift
//  vkClient
//
//  Created by MacBook Pro on 14.02.2021.
//

import Foundation

class ParseDataOperation<T:Codable>: Operation {

    var outputData: [T]?

    override func main() {

        guard let getDataOperation = dependencies.first as? GetDataOperation,
              let data = getDataOperation.data else { return }

        guard let parsedData = try? JSONDecoder().decode(Response<T>.self, from: data).response.items else {
            print("Error in ParseDataOperation")
            return
        }
        outputData = parsedData
    }


}

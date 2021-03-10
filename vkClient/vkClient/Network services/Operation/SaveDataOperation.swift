//
//  SaveDataOperation.swift
//  vkClient
//
//  Created by MacBook Pro on 14.02.2021.
//

import Foundation
import RealmSwift

class SavingDataOperation<T: Object & Codable>: Operation {

    override func main() {
        
        guard let parseDataOperation = dependencies.first as? ParseDataOperation<T>,
              let outputData = parseDataOperation.outputData else { return }

        do {
            let realm = try Realm()
            let oldValues = realm.objects(T.self)
            realm.beginWrite()
            realm.delete(oldValues)
            realm.add(outputData)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }


}

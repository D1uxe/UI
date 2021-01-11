//
//  RealmService.swift
//  vkClient
//
//  Created by MacBook Pro on 11.01.2021.
//

import Foundation
import RealmSwift

class RealmService {

    func saveData<T: Object>(objects: [T]) {
        // обработка исключений при работе с хранилищем
        do {
            // получаем доступ к хранилищу
            let realm = try Realm()
            // начинаем изменять хранилище
            realm.beginWrite()
            // кладем все переданные в функцию объекты в хранилище
            realm.add(objects)
            // завершаем изменения хранилища
            try realm.commitWrite()
        } catch {
            // если произошла ошибка, выводим ее
            print(error)
        }
    }

//    func loadData<T: Object>() -> [T] {
//
//        return
//    }

}

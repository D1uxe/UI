//
//  RealmService.swift
//  vkClient
//
//  Created by MacBook Pro on 11.01.2021.
//

import Foundation
import RealmSwift

class RealmService {
 
    class func updateFriendsInRelm() {

        QueryFriends.get(completion: { friends in
            // обработка исключений при работе с хранилищем
            do {
                // получаем доступ к хранилищу
                let realm = try Realm()

                //print(realm.configuration.fileURL!)

                // получим старые объекты из базы
                let oldValues = realm.objects(Friend.self)

                // начинаем изменять хранилище
                realm.beginWrite()

                // удалим старые данные
                realm.delete(oldValues)

                // кладем все переданные в функцию объекты в хранилище
                realm.add(friends)

                // завершаем изменения хранилища
                try realm.commitWrite()

            } catch {
                // если произошла ошибка, выводим ее
                print(error)
            }
        })

    }
// Получение, парсинг и обновление происходит через OperationQueue
    class func updateGroupsInRealm() {

        let queue = OperationQueue()

        guard let url = QueryGroups.getUrlForGroupRequest() else { return }

        let getDataOperation = GetDataOperation(url: url)
        queue.addOperation(getDataOperation)

        let parseDataOperation = ParseDataOperation<Group>()
        parseDataOperation.addDependency(getDataOperation)
        queue.addOperation(parseDataOperation)

        let savingDataOperation = SavingDataOperation<Group>()
        savingDataOperation.addDependency(parseDataOperation)
        queue.addOperation(savingDataOperation)


        /* deprecated
        QueryGroups.get(completion: { groups in
            do {
                let realm = try Realm()
                let oldValues = realm.objects(Group.self)
                realm.beginWrite()
                realm.delete(oldValues)
                realm.add(groups)
                try realm.commitWrite()
            } catch {
                print(error)
            }
        })
         */
    }


    


    class func updatePhotosInRealm(for userId: Int?) {

        QueryPhotos.getAll(for: userId, completion: { photos in
            do {
                let realm = try Realm()
                let oldValues = realm.objects(Photo.self).filter("ownerId == %@", userId ?? -1)
                realm.beginWrite()
                realm.delete(oldValues)
                realm.add(photos)
                try realm.commitWrite()
            } catch {
                print(error)
            }
        })
    }


    /* Methods for lesson 6. Deprecated
        class func saveData<T: Object>(objects: [T]) {
         // let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

             // обработка исключений при работе с хранилищем
             do {
                 // получаем доступ к хранилищу
                let realm = try Realm()
                 let oldValues = realm.objects(T.self)
                 // начинаем изменять хранилище
                 realm.beginWrite()
                 // удалим старые данные
                 realm.delete(oldValues)
                 // кладем все переданные в функцию объекты в хранилище
                 realm.add(objects)
                 // завершаем изменения хранилища
                 try realm.commitWrite()
             } catch {
                 // если произошла ошибка, выводим ее
                 print(error)
             }
         }

        class func loadData<T: Object>(of type: T.Type) -> [T] {

             do {
                 let realm = try Realm()
                 let obj = realm.objects(type)
                 return Array(obj)
             } catch {
                 print(error)
                 return []
             }
         }

       class func saveData<T: Photo>(for ownerId: Int?, objects: [T]) {

            do {
                let realm = try Realm()
                let oldValues = realm.objects(T.self).filter("ownerId == %@", ownerId ?? -1)
                realm .beginWrite()
                realm.delete(oldValues)
                realm.add(objects)
                try realm .commitWrite()
            } catch  {
                print(error)
            }
         }

        class func loadData<T: Photo>(for ownerId: Int?, of type: T.Type) -> [T] {

            do {
                let realm = try Realm()
                let obj = realm.objects(type).filter("ownerId == %@", ownerId ?? -1)
                return Array(obj)
            } catch {
                print(error)
                return []
            }
        }
     */

}

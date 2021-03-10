//
//  QueryPhotos.swift
//  vkClient
//
//  Created by MacBook Pro on 24.12.2020.
//

import Foundation


/// Класс запросов к vk API для работы с фотографиями
class QueryPhotos {

    private init() {}

    /// Возвращает все фотографии пользователя или сообщества в антихронологическом порядке
    /// - Parameters:
    ///   - ownerId: идентификатор пользователя или сообщества, фотографии которого нужно получить.  Для сообществ идентификатор необходимо указывать со знаком "-"
    ///   - completion: замыкание для возврата результата запроса. После успешного выполнения возвращает массив объектов Photo.
    class func getAll(for ownerId: Int?, completion: @escaping ([Photo]) -> Void) {

        guard let ownerId = ownerId else { return }
        var urlConstructor = URLComponents()
        let session = URLSession.shared

        urlConstructor.scheme = NetworkConstants.scheme
        urlConstructor.host = NetworkConstants.host
        urlConstructor.path = "/method/photos.getAll"
        urlConstructor.queryItems = [
            URLQueryItem(name: "owner_id", value: String(ownerId)),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "photo_sizes", value: "1"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: NetworkConstants.versionAPI)
        ]

        guard let url = urlConstructor.url else { return }
        session.dataTask(with: url) { (data, response, error) in

            guard let data = data else { return }

            /*
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("********** PHOTOS *********")
                print(json)
            } catch {
                print("Photos. Ошибка сериализации JSON \(error)")
            }
             */

            do {
                let photos = try JSONDecoder().decode(Response<Photo>.self, from: data).response.items
                DispatchQueue.main.async {
                    //RealmService.saveData(for: ownerId, objects: photos)
                    completion(photos)
                }
            } catch  {
                print(error)
            }

        }.resume()
    }

}

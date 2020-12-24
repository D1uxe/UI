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
    /// - Parameter ownerId: Идентификатор владельца альбома. Для сообществ идентификатор необходимо указывать со знаком "-"
    class func getAll(for ownerId: Int?) {

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
            //print(data)

            //guard let response = response else { return }
            //print(response)
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("********** PHOTOS *********")
                print(json)
            } catch {
                print("Photos. Ошибка сериализации JSON \(error)")
            }
        }.resume()
    }

}

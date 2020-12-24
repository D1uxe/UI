//
//  QueryFriends.swift
//  vkClient
//
//  Created by MacBook Pro on 24.12.2020.
//

import Foundation

/// Дополнительные поля для возврата расширенной информации о друзьях пользователя
enum FriendFields: String {
    case nickname
    case domain
    case photo_50
    case photo_100
    case photo_200_orig
    case sex
    case bdate
    case city
    case country
    case timezone
    case has_mobile
    case contacts
    case education
    case online
    case relation
    case last_seen
    case status
    case can_write_private_message
    case can_see_all_posts
    case can_post
    case universities

}



/// Класс запросов к vk API для работы с друзьями
class QueryFriends {

    private init() {}

    /// Возвращает список идентификаторов друзей пользователя или расширенную информацию о друзьях пользователя (при использовании параметра fields).
    /// - Parameter fields: список дополнительных полей, которые необходимо вернуть.
    class func get(fields: [FriendFields] = [FriendFields.photo_200_orig]) {

        let field = fields.lazy.map({ $0.rawValue }).joined(separator: ",")

        var urlConstructor = URLComponents()
        let session = URLSession.shared

        urlConstructor.scheme = NetworkConstants.scheme
        urlConstructor.host = NetworkConstants.host
        urlConstructor.path = "/method/friends.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: ""),
            URLQueryItem(name: "order", value: "hints"),
            URLQueryItem(name: "fields", value: field),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: NetworkConstants.versionAPI),
        ]

        guard let url = urlConstructor.url else { return }
        session.dataTask(with: url) { data, response, error in

            guard let dat = data else { return }
            //print(dat)

            //guard let respon = response else { return }
            //print(respon)

            do {
                let json = try JSONSerialization.jsonObject(with: dat, options: [])
                print("++++++++++++ FRIENDS ++++++++++++")
                print(json)
            } catch {
                print("Friends. Ошибка сериализации JSON \(error)")
            }
        }.resume()
    }
    
}

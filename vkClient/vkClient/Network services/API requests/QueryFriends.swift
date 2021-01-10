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
    /// - Parameters:
    ///   - fields: список дополнительных полей, которые необходимо вернуть
    ///   - completion: замыкание для возврата результата запроса. После успешного выполнения при использовании параметра fields возвращает список объектов пользователей, но не более 5000.
    class func get(fields: [FriendFields] = [FriendFields.photo_100], completion: @escaping ([Friend]) -> Void) {

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
            URLQueryItem(name: "count", value: ""),
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: NetworkConstants.versionAPI),
        ]

        guard let url = urlConstructor.url else { return }
        session.dataTask(with: url) { data, response, error in

            guard let data = data else { return }

            /*
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("++++++++++++ FRIENDS ++++++++++++")
                print(json)
            } catch {
                print("Friends. Ошибка сериализации JSON \(error)")
            }
             */

            do {
                let friends = try JSONDecoder().decode(Response<Friend>.self, from: data).response.items
                DispatchQueue.main.async {
                    completion(friends)
                }
            } catch {
                print (error)
            }

        }.resume()
    }
    
}

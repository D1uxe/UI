//
//  QueryFriends.swift
//  vkClient
//
//  Created by MacBook Pro on 24.12.2020.
//

import Foundation

/// Дополнительные поля для возврата расширенной информации о сообществах пользователя
enum GroupFields: String {

    case city
    case country
    case place
    case description
    case wiki_page
    case members_count
    case counters
    case start_date
    case finish_date
    case can_post
    case can_see_all_posts
    case activity
    case status
    case contacts
    case links
    case fixed_post
    case verified
    case site
    case can_create_topic

}



/// Класс запросов к vk API для работы с сообществами
class QueryGroups {

    private init() {}

    /// Возвращает список сообществ указанного пользователя
    /// - Parameter fields: список дополнительных полей, которые необходимо вернуть.
    class func get(fields: [GroupFields] = [GroupFields.description]) {

        let field = fields.lazy.map({ $0.rawValue }).joined(separator: ",")

        var urlConstructor = URLComponents()
        let session = URLSession.shared

        urlConstructor.scheme = NetworkConstants.scheme
        urlConstructor.host = NetworkConstants.host
        urlConstructor.path = "/method/groups.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
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
                print("=========== GROUPS ===========")
                print(json)
            } catch {
                print("Groups.Ошибка сериализации JSON \(error)")
            }
        }.resume()

    }


    /// Осуществляет поиск сообществ по заданной подстроке
    /// - Parameter name: имя искомого сообщества
    class func search(group name: String?) {

        var urlConstructor = URLComponents()
        let session = URLSession.shared

        urlConstructor.scheme = NetworkConstants.scheme
        urlConstructor.host = NetworkConstants.host
        urlConstructor.path = "/method/groups.search"
        urlConstructor.queryItems = [
            URLQueryItem(name: "q", value: name),
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
                print("=========== SEARCH GROUP ===========")
                print(json)
            } catch {
                print("GroupsSearch.Ошибка сериализации JSON \(error)")
            }
        }.resume()
    }

}

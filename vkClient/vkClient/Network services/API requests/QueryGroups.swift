//
//  QueryGroups.swift
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
    case is_member
    case member_status
    case counters
    case start_date
    case finish_date
    case can_post
    case can_see_all_posts
    case activity
    case is_closed
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
    /// - Parameters:
    ///   - fields: список дополнительных полей, которые необходимо вернуть.
    ///   - completion: замыкание для возврата результата запроса. После успешного выполнения возвращает массив объектов сообществ.
    class func get(fields: [GroupFields] = [GroupFields.description], completion: @escaping ([Group]) -> Void) {

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
        session.dataTask(with: url) { data, _, error in

            guard let data = data else { return }

            /*
                 do {
                     let json = try JSONSerialization.jsonObject(with: data, options: [])
                     print("=========== GROUPS ===========")
                     print(json)
                 } catch {
                     print("Groups.Ошибка сериализации JSON \(error)")
                 }
             */

            do {
                let groups = try JSONDecoder().decode(Response<Group>.self, from: data).response.items
                DispatchQueue.main.async {
                    //RealmService.saveData(objects: groups)
                    completion(groups)
                }
            } catch {
                print(error)
            }

        }.resume()
    }


    /// Осуществляет поиск сообществ по заданной подстроке
    /// - Parameters:
    ///   - name: имя искомого сообщества
    ///   - completion: замыкание для возврата результата запроса. После успешного выполнения возвращает массив объектов Group.
    class func search(group name: String?, completion: @escaping ([Group]) -> Void) {

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
        session.dataTask(with: url) { data, _, error in

            guard let data = data else { return }

            /*
             do {
                 let json = try JSONSerialization.jsonObject(with: dat, options: [])
                 print("=========== SEARCH GROUP ===========")
                 print(json)
             } catch {
                 print("GroupsSearch.Ошибка сериализации JSON \(error)")
             }
              */

            do {
                let searchedGroups = try JSONDecoder().decode(Response<Group>.self, from: data).response.items
                DispatchQueue.main.async {
                    completion(searchedGroups)
                }
            } catch {
                print(error)
            }

        }.resume()
    }



    /// Метод позволяет вступить в группу, публичную страницу, а также подтвердить участие во встрече.
    /// - Parameters:
    ///   - groupId: идентификатор сообщества
    ///   - completion: замыкание для возврата результата запроса. В случае успешного вступления метод вернёт 1
   class func join(groupId: Int, completion: @escaping (Int) -> Void) {

        var UrlConstructor = URLComponents()
        let session = URLSession.shared

        UrlConstructor.scheme = NetworkConstants.scheme
        UrlConstructor.host = NetworkConstants.host
        UrlConstructor.path = "/method/groups.join"
        UrlConstructor.queryItems = [
            URLQueryItem(name: "group_id", value: String(groupId)),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: NetworkConstants.versionAPI)
        ]

        guard let url = UrlConstructor.url else { return }

        session.dataTask(with: url, completionHandler: { data, _, error in

            guard let data = data else { return }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])

                guard let responseJson = json as? [String: Int] else { return }
                let response = responseJson["response"]!

                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print(error)
            }
        }).resume()

    }


    /// Позволяет покинуть сообщество или отклонить приглашение в сообщество
    /// - Parameters:
    ///   - groupId: идентификатор сообщества
    ///   - completion: замыкание для возврата результата запроса. После успешного выполнения возвращает 1
    class func leave(groupId: Int, completion: @escaping (Int) -> Void) {

        var urlConstructor = URLComponents()

        urlConstructor.scheme = NetworkConstants.scheme
        urlConstructor.host = NetworkConstants.host
        urlConstructor.path = "/method/groups.leave"
        urlConstructor.queryItems = [
            URLQueryItem(name: "group_id", value: String(groupId)),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: NetworkConstants.versionAPI)
        ]

        guard let url = urlConstructor.url else { return }

        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in

            guard let data = data else { return }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])

                let responseJson = json as! [String: Int]
                let response = responseJson["response"]!
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print(error)
            }

        }).resume()

    }





}

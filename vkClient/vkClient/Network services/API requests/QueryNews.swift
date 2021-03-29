//
//  QueryNews.swift
//  vkClient
//
//  Created by MacBook Pro on 11.02.2021.
//

import Foundation


/// Класс запросов к vk API для работы с лентой новостей
class QueryNews {

    private init() {}

    /// Метеод для получения автора новости и его аватарки
    /// - Parameters:
    ///   - news: Модель новости в которой заполняются свойства postAuthor и postAuthorAvatarUrl
    ///   - newsPublisher: Массивы групп и юзеров из которых получаем автора. Для каждой новости это либо группа либо юзер
    private class func getPostAuthor(in news: inout [Post], from newsPublisher: ItemsNews) {

        for i in 0..<news.count {
            if news[i].sourceId < 0 { // если автор новости группа
                if let publisherGroup = newsPublisher.groups.first(where: { $0.id == -news[i].sourceId }) {
                    news[i].postAuthor = publisherGroup.name
                    news[i].postAuthorAvatarUrl = publisherGroup.avatarURL
                }
            } else { // если автор новости юзер
                if let publisherProfile = newsPublisher.profiles.first(where: { $0.id == news[i].sourceId }) {
                    news[i].postAuthor = publisherProfile.firstName
                    news[i].postAuthorAvatarUrl = publisherProfile.avatarURL
                }
            }
        }
    }


    /// Возвращает данные, необходимые для показа списка новостей для текущего пользователя
    /// - Parameters:
    ///   - startTime: время в формате unixtime, начиная с которого следует получить новости для текущего пользователя.
    ///   - startFrom: идентификатор, необходимый для получения следующей страницы результатов. Значение, необходимое для передачи в этом параметре, возвращается в поле ответа next_from.
    ///   - completion: замыкание для возврата результата запроса
    class func get(startTime: String = "", startFrom: String? = "", completion: @escaping ([Post], String?) -> Void) {

        // vk api после того как прислал последнюю страницу новстей, поле next_from отсутсвует, соответственно загружать больше нечего выходим.
        guard let startFrom = startFrom else { return }

        var urlConstructor = URLComponents()
        let session = URLSession.shared

        urlConstructor.scheme = NetworkConstants.scheme
        urlConstructor.host = NetworkConstants.host
        urlConstructor.path = "/method/newsfeed.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "start_time", value: startTime),
            URLQueryItem(name: "start_from", value: startFrom),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "v", value: NetworkConstants.versionAPI),
            URLQueryItem(name: "access_token", value: Session.shared.token)
        ]

        guard let url = urlConstructor.url else { return }

        let sessionTask = session.dataTask(with: url, completionHandler: { data, response, error in

            guard let data = data else { return }

            var news: [Post]

            do {
                let newsResponse = try JSONDecoder().decode(ResponseNews.self, from: data).response
                news = newsResponse.items
                getPostAuthor(in: &news, from: newsResponse)
                
                DispatchQueue.main.async {
                    completion(news, newsResponse.nextFrom)
                }
            } catch {
                print(error)
            }

        })
        DispatchQueue.global().async {
            sessionTask.resume()
        }
    }

}

//
//  NetworkService.swift
//  vkClient
//
//  Created by MacBook Pro on 20.12.2020.
//

import Foundation

class NetworkService {

    private var urlConstructor = URLComponents()

    func getAuthorizeRequest() -> URLRequest? {

        urlConstructor.scheme = NetworkConstants.scheme
        urlConstructor.host = "oauth.vk.com"
        urlConstructor.path = "/authorize"
        urlConstructor.queryItems = [
            URLQueryItem(name: "client_id", value: NetworkConstants.appId),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: NetworkConstants.scope),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: NetworkConstants.versionAPI)
        ]

        guard let url = urlConstructor.url else { return nil }
        let request = URLRequest(url: url)
        return request
    }
}

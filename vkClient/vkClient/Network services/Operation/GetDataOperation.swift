//
//  GetDataOperation.swift
//  vkClient
//
//  Created by MacBook Pro on 14.02.2021.
//

import Foundation

class GetDataOperation: AsyncOperation {

    private var urlConstructor = URLComponents()
    private let configuration: URLSessionConfiguration!
    private let session: URLSession!
    private var url: URL
    private var task: URLSessionTask?

    var data: Data?


    init(url: URL) {

        urlConstructor.scheme = NetworkConstants.scheme
        urlConstructor.host = NetworkConstants.host
        configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)

        self.url = url
    }


    override func cancel() {

        task?.cancel()
        super.cancel()
    }

    override func main() {

        task = session.dataTask(with: url, completionHandler: { (data, response, error) in

            guard let data = data else { return }

            self.data = data
            self.state = .finished
        })
        task?.resume()
    }


}

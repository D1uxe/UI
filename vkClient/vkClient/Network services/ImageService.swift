//
//  ImageService.swift
//  vkClient
//
//  Created by MacBook Pro on 28.12.2020.
//

import UIKit

class ImageService {


    /// Возаращает image по переданному URL
    /// - Parameters:
    ///   - url: ссылка на картинку
    ///   - completion: Замыкание для возврата результата запроса. После успешного выполнения возвращает объект UIImage
    func getPhoto(byURL url: String, completion: @escaping (UIImage) -> Void) {

        var image: UIImage?

        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

            guard let data = data else { return }
            image = UIImage(data: data)
            DispatchQueue.main.async {
                completion(image!)
            }

        }).resume()


    }
}

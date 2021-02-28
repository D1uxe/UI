//
//  ImageService.swift
//  vkClient
//
//  Created by MacBook Pro on 28.12.2020.
//

import UIKit


class ImageService {

    //MARK: - Private Properties

    private let container: DataReloadable?

    private let cacheLifeTime: TimeInterval = 60 * 60 * 24 * 7
    private static var memoryCash = [String: UIImage]()

    /// имя папки, в которую сохраняются изображения
    private static let pathName: String = {

        let pathName = "images"

        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)

        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }

        return pathName
    }()


    //MARK: - Initializers

    init(container: UITableView) {
        self.container = Table(table: container)
    }

    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }

    init() {
        container = nil
    }

    //MARK: - Public Methods

    func getPhoto(atIndexpath indexPath: IndexPath, byUrl url: String) -> UIImage? {

        var image: UIImage?
        if let photo = ImageService.memoryCash[url] {
            image = photo
        } else
        if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(atIndexpath: indexPath, byUrl: url)
        }
        return image
    }


    //MARK: - Private Methods

    private func getFilePath(url: String) -> String? {

        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }

        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(ImageService.pathName + "/" + hashName).path
    }

    private func saveImageToCache(url: String, image: UIImage) {

        guard let fileName = getFilePath(url: url),
              let data = image.pngData() else { return }
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }

    private func getImageFromCache(url: String) -> UIImage? {

        guard
            let fileName = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }

        let lifeTime = Date().timeIntervalSince(modificationDate)

        guard
            lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName) else { return nil }

        DispatchQueue.main.async {
            ImageService.memoryCash[url] = image
        }
        return image
    }

    private func loadPhoto(atIndexpath indexPath: IndexPath, byUrl url: String ) {

        guard let urlRequest = URL(string: url) else { return }
        let request = URLRequest(url: urlRequest)

        URLSession.shared.dataTask(with: request) { (data, _, _ ) in
            guard
                let data = data,
                let image = UIImage(data: data) else { return }

            DispatchQueue.main.async {
                ImageService.memoryCash[url] = image
            }

            self.saveImageToCache(url: url, image: image)

            DispatchQueue.main.async { [unowned self] in
                self.container?.reloadRow(atIndexpath: indexPath)
            }
        }.resume()
    }

}


//MARK: - DataReloadable

fileprivate protocol DataReloadable {

    func reloadRow(atIndexpath indexPath: IndexPath)
}

extension ImageService {

    private class Table: DataReloadable {

        let table: UITableView

        init(table: UITableView) {
            self.table = table
        }

        func reloadRow(atIndexpath indexPath: IndexPath) {

            table.reloadRows(at: [indexPath], with: .none)

        }
    }

    private class Collection: DataReloadable {

        let collection: UICollectionView

        init(collection: UICollectionView) {
            self.collection = collection
        }

        func reloadRow(atIndexpath indexPath: IndexPath) {

            collection.reloadItems(at: [indexPath])
        }
    }

}

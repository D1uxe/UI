//
//  NewsTableViewController.swift
//  vkClient
//
//  Created by MacBook Pro on 15.11.2020.
//

import UIKit

class NewsTableViewController: UITableViewController {

    // MARK: - Private Properties

    private var news: [Post] = []
    private lazy var imageService = ImageService(container: self.tableView)
    private var isLoading = false
    private var nextFrom: String?
    private var expandedCells = Set<Int>()
    private var isExpanded: Bool = false

    private let proxy = QueryNewsProxy(service: QueryNews())


    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupRefreshControl()

        proxy.get(completion: { (post, nextFrom) in
            self.news = post
            self.nextFrom = nextFrom
            self.tableView.reloadData()
        })
    }

    
    //MARK: - Private Methods

    private func setupRefreshControl() {

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing...")
        self.refreshControl?.tintColor = ColorFlyWeight.basicAppColor
        self.refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }

    @objc private func refreshNews() {

        // Определяем время самой свежей новости или берем текущее время
        let mostFreshNewsDate = self.news.first?.unixTimeDate ?? Date().timeIntervalSince1970

        isLoading = true
        proxy.get(startTime: String(mostFreshNewsDate + 1), completion: { (post, _) in

            self.refreshControl?.endRefreshing()

            guard post.count > 0 else { return }

            self.news = post + self.news

            let indexSet = IndexSet(integersIn: 0..<post.count)
            self.tableView.insertSections(indexSet, with: .automatic)
            self.isLoading = false
        })
    }

    private func getCellPrototype(news: Post, indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHeaderTableViewCell", for: indexPath) as! NewsHeaderTableViewCell

            let avatar = imageService.getPhoto(atIndexpath: indexPath, byUrl: news.postAuthorAvatarUrl)

            isExpanded = expandedCells.contains(indexPath.section)

            cell.configure(postAuthor: news.postAuthor,
                           avatar: avatar,
                           newsTime: news.postDateTime,
                           newsText: news.text,
                           section: indexPath.section,
                           isExpanded: isExpanded)

            cell.delegate = self

            return cell
        }
        else if indexPath.row == 2 || !news.hasImage {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFooterTableViewCell", for: indexPath) as! NewsFooterTableViewCell

            cell.configure(likeCount: news.likes.likesCount,
                           likeState: news.likes.isLikedByUser,
                           commentCount: news.comments.count,
                           repostCount: news.reposts.count,
                           viewsCount: news.views.count)

            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPhotoTableViewCell", for: indexPath) as! NewsPhotoTableViewCell

            if let photo = imageService.getPhoto(atIndexpath: indexPath, byUrl: (news.atachedPhotosUrl?.first)!) {
                cell.configure(newsPhoto: photo)
            }
            return cell
        }

    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return news.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if news[section].hasImage {
            return 3
        } else {
            return 2
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return  getCellPrototype(news: news[indexPath.section], indexPath: indexPath)

    }


    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        guard indexPath.row == 1,
              news[indexPath.section].hasImage,
              let ratio = self.news[indexPath.section].aspectRatio?.last else { return UITableView.automaticDimension }

        // Вычисляем высоту
        return  tableView.bounds.size.width * ratio
    }
    
}


    // MARK: - TableViewDataSourcePrefetching

extension NewsTableViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

        // Выбираем максимальный номер секции, которую нужно будет отобразить в ближайшее время
        guard let maxSection = indexPaths.map({ $0.section}).max() else { return }

        // Проверяем,является ли эта секция одной из трех ближайших к концу
        if maxSection > news.count - 3,
           // Убеждаемся, что мы уже не в процессе загрузки данных
           !isLoading {
            // Начинаем загрузку данных
            isLoading = true

            proxy.get(startFrom: self.nextFrom, completion: { (post, nextFrom) in

                // Прикрепляем новости к cуществующим новостям
                let indexSet = IndexSet(integersIn: self.news.count ..< self.news.count + post.count)

                self.nextFrom = nextFrom
                self.news.append(contentsOf: post)

                // Обновляем таблицу
                self.tableView.insertSections(indexSet, with: .automatic)

                // Выключаем статус isLoading
                self.isLoading = false
            })
        }
    }

}


    // MARK: - NewsHeaderCellDelegate

extension NewsTableViewController: NewsHeaderCellDelegate {

    func showMoreTapped(section: Int) {

        if !self.expandedCells.contains(section) {
            self.expandedCells.insert(section)
        }
        tableView.performBatchUpdates(nil)
    }

}

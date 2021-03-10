//
//  NewsFeed.swift
//  vkClient
//
//  Created by MacBook Pro on 11.02.2021.
//

import Foundation
import CoreGraphics

struct ResponseNews: Codable {

    let response: ItemsNews
}


struct ItemsNews: Codable {

    let items: [Post]
    let profiles: [Friend]
    let groups: [Group]
    let nextFrom: String?

    enum CodingKeys: String, CodingKey {

        case items
        case profiles
        case groups
        case nextFrom = "next_from"
    }
}

// MARK: - Модель новости -
struct Post: Codable {

    let sourceId: Int
    let unixTimeDate: Double
    let text: String
    let postId: Int

    let attachments: [Attachment]?
    let comments: Comment
    let likes: Like
    let reposts: Repost
    let views: Views

    var postAuthorAvatarUrl: String!
    var postAuthor: String!
    var atachedPhotosUrl: [String]? {
        get {
            let photosUrl = attachments?.compactMap{ $0.photo?.sizes.last?.url }
            return photosUrl
        }
    }
    var postDateTime: String! {
        get {
            return unixTimeToString()
        }
    }
    var hasImage: Bool {
        if let url = atachedPhotosUrl?.first {
            return !url.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
        return false
    }

    var aspectRatio: [CGFloat]? {
        let ratio = attachments?.compactMap{ $0.photo?.sizes.last?.ratio }
        return ratio
    }

    enum CodingKeys: String, CodingKey {

        case sourceId = "source_id"
        case unixTimeDate = "date"
        case text
        case postId = "post_id"
        case attachments
        case comments
        case likes
        case reposts
        case views
    }

    private func unixTimeToString() -> String {

        let dateFormatter = DateFormatter()

      if Calendar.current.compare(Date(timeIntervalSince1970: self.unixTimeDate),
                                  to: Date(),
                                  toGranularity: .day) == .orderedSame {
            dateFormatter.dateFormat = "Сегодня в HH:mm"
        } else {
            dateFormatter.dateFormat = "dd MMMM в HH:mm"
        }
        dateFormatter.locale = Locale(identifier: "ru")
        let date = Date(timeIntervalSince1970: self.unixTimeDate)
        return dateFormatter.string(from: date)
    }

}



struct Attachment: Codable {

    let type: String?
    let photo: Photo?
}

struct Comment: Codable {

    let count: Int
}

struct Repost: Codable {

    let count: Int
}

struct Views: Codable {

    let count: Int
}

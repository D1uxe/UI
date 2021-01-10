//
//  Friend.swift
//  vkClient
//
//  Created by MacBook Pro on 26.12.2020.
//

import Foundation

class Friend: Codable {

    var id: Int = 0
    var firstName: String = ""
    var lastName: String = ""
    var avatarURL: String = ""
    var city: City?
    var country: Country?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarURL = "photo_100"
        case city
        case country
    }

}

class City: Codable {
    var title: String = ""
}

class Country: Codable {
    var title: String = ""
}


/* спосбо 2. Ручной декодинг
class FFriend: Decodable {

    var id: Int = 0
    var firstName: String = ""
    var lastName: String = ""
    var avatarURL: String = ""
    var cityTitle: String = ""
    var countryTitle: String = ""

    enum ItemsKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_100"
        case city
        case country
    }

    enum CityKeys: String, CodingKey {
        case cityTitle = "title"
    }

    enum CountryKeys: String, CodingKey {
        case countryTitle = "title"
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()

        let values = try decoder.container(keyedBy: ItemsKeys.self)

        id = try values.decode(Int.self, forKey: .id)
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
        avatarURL = try values.decode(String.self, forKey: .photo)

        //Если пользователь не указал город, то вк почему-то не присылает даже сами ключи,
        //поэтому если вложенного контейнера нет, то установим городу прочерк
        if let cityValue = try? values.nestedContainer(keyedBy: CityKeys.self, forKey: .city) {
            self.cityTitle = try cityValue.decode(String.self, forKey: .cityTitle)
        } else {
            self.cityTitle = "-"
        }

        if let countryValue = try? values.nestedContainer(keyedBy: CountryKeys.self, forKey: .country) {
            self.countryTitle = try countryValue.decode(String.self, forKey: .countryTitle)
        } else {
            self.countryTitle = "-"
        }
    }
}

*/


/* deprecated
struct Friend {
    let name: String
    let avatar: String
    let photo: [String]
}

struct Friends {
    var friendsList: [Friend] = [
        Friend(name: "Натали Романов", avatar: "BlackWidow", photo: ["BlackWidow1", "BlackWidow2"]),
        Friend(name: "Toni Iron Man Stark", avatar: "IronMan", photo: ["IronMan1", "IronMan2", "IronMan3", "IronMan4", "IronMan5", "IronMan6", "IronMan1", "IronMan3"]),
        Friend(name: "Брюс Hulk Беннер", avatar: "Hulk", photo: ["Hulk1", "Hulk2"]),
        Friend(name: "Wonder Woman", avatar: "WonderWoman", photo: ["WonderWoman1", "WonderWoman2"]),
        Friend(name: "Tanos", avatar: "Tanos", photo: ["Tanos1", "Tanos2", "Tanos3"]),
        Friend(name: "Groot", avatar: "Groot", photo: ["Groot1", "Groot2", "Groot3"]),
        Friend(name: "Питер Паркер", avatar: "SpiderMan", photo: []),

//        Friend(name: "Supreme", avatar: "Supreme", photo: []),
//        Friend(name: "Salut", avatar: "Salut", photo: []),
//        Friend(name: "Member", avatar: "Member", photo: []),
//        Friend(name: "Memory", avatar: "Memory", photo: []),
//        Friend(name: "Got", avatar: "Groot", photo: ["Groot1", "Groot2","Groot3"]),
//        Friend(name: "Gosha", avatar: "Groot", photo: ["Groot1", "Groot2","Groot3"]),
    ]
}
 */

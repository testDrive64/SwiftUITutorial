//
//  User.swift
//  CupcakeCorner
//
//  Created by Norman on 23.03.25.
//

import Foundation

struct User: Codable {
//    enum CodingKeys: String, CodingKey {
//        case _name = "name"
//        case _city = "city"
//        case _streetAddress = "streetAddress"
//        case _zip = "zip"
//    }
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "user") {
            if let decodedItem = try? JSONDecoder().decode(User.self, from: savedItems) {
                name = decodedItem.name
                streetAddress = decodedItem.streetAddress
                city = decodedItem.city
                zip = decodedItem.zip
                return
            }
        }

    }
    
    init(name: String, streetAddress: String, city: String, zip: String) {
        self.name = name
        self.streetAddress = streetAddress
        self.city = city
        self.zip = zip
    }
}

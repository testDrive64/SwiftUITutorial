//
//  Order.swift
//  CupcakeCorner
//
//  Created by Norman on 19.03.25.
//

import SwiftUI

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _user = "user"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var user: User = User() {
        didSet {
            if let encoded = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(encoded, forKey: "user")
            }
        }
    }
    
//    var name = ""
//    var streetAddress = ""
//    var city = ""
//    var zip = ""
    
    var hasValidAddress: Bool {
        
        let charSet = NSCharacterSet.letters
        let decimalSet = NSCharacterSet.decimalDigits
        
        if user.name.isEmpty || user.streetAddress.isEmpty || user.city.isEmpty || user.zip.isEmpty {
            return false
        }
        
        if user.name.rangeOfCharacter(from: charSet) == nil || user.streetAddress.rangeOfCharacter(from: charSet) == nil || user.city.rangeOfCharacter(from: charSet) == nil || user.zip.rangeOfCharacter(from: decimalSet) == nil {
            return false
        }
        
        
        return true
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        
        cost += Decimal(type) / 2
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
    
}

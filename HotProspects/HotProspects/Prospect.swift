//
//  Prospect.swift
//  HotProspects
//
//  Created by Norman on 30.05.25.
//

import Foundation
import SwiftData

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    
    init(name: String, emailAddress: String, isContected: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContected
    }
}

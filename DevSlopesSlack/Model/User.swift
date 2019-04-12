//
//  User.swift
//  DevSlopesSlack
//
//  Created by Mark Struzinski on 4/11/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import Foundation

struct User: Codable {
    let userName: String
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case userName = "user"
        case token
    }
}

//
//  SlackUser.swift
//  DevSlopesSlack
//
//  Created by Mark Struzinski on 4/11/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import Foundation

struct SlackUser: Codable {
    let userId: String
    let avatarColor: String
    let avatarName: String
    let email: String
    let userName: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "_id"
        case avatarColor
        case avatarName
        case email
        case userName = "name"
    }
}

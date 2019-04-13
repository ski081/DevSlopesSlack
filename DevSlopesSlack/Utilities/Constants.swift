//
//  Constats.swift
//  DevSlopesSlack
//
//  Created by Mark Struzinski on 2/28/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import Foundation
import Cocoa

typealias CompletionHandler = (Bool) -> Void

let baseURL = "https://slack-clone-ski081.herokuapp.com/v1/"
let urlRegister = "\(baseURL)account/register"
let urlLogin = "\(baseURL)account/login"
let urlUserAdd = "\(baseURL)user/add"
let urlUserByEmail = "\(baseURL)user/byEmail"

let chatPurple = NSColor(calibratedRed: 0.30,
                         green: 0.22,
                         blue: 0.29,
                         alpha: 1.0)
let chatGreen = NSColor(calibratedRed: 0.22,
                        green: 0.66,
                        blue: 0.68,
                        alpha: 1.0)
let avenirRegular = "AvenirNext-Regular"
let avenirBold = "AvenirNext-Bold"
let userInfoModal = "modalUserInfo"
let removeModalImmediately = "modalRemoveImmediately"
let tokenKey = "token"
let loggedInKey = "loggedIn"
let userEmailKey = "userEmail"

let serviceHeaders = [
    "Content-Type": "application/json; charset=utf-8"
]

let bearerHeaders = [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]


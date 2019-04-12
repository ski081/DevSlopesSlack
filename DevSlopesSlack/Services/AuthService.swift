//
//  AuthService.swift
//  DevSlopesSlack
//
//  Created by Mark Struzinski on 4/8/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import Foundation
import Alamofire

class AuthService {
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: loggedInKey)
        }
        set {
            defaults.set(newValue, forKey: loggedInKey)
        }
    }
    
    var authToken: String {
        get {
            return defaults.string(forKey: tokenKey)!
        }
        set {
            defaults.set(newValue, forKey: tokenKey)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.string(forKey: userEmailKey)!
        }
        set {
            defaults.set(newValue, forKey: userEmailKey)
        }
    }

    func registerUser(email: String,
                      password: String,
                      completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(urlRegister,
                          method: .post,
                          parameters: body,
                          encoding: JSONEncoding.default,
                          headers: serviceHeaders)
            .responseString { response in
                if response.result.error == nil {
                    completion(true)
                } else {
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
        }
    }
    
    func loginUser(email: String,
                   password: String,
                   completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]

        Alamofire.request(urlLogin,
                          method: .post,
                          parameters: body,
                          encoding: JSONEncoding.default,
                          headers: serviceHeaders)
            .responseJSON { response in
                if response.result.error == nil {
                    guard let data = response.data else {
                        completion(false)
                        return
                    }
                    
                    let jsonDecoder = JSONDecoder()
                    guard let user = try? jsonDecoder.decode(User.self, from: data) else {
                        completion(false)
                        return
                    }
                    
                    self.userEmail = user.userName
                    self.authToken = user.token
                    self.isLoggedIn = true
                    completion(true)
                } else {
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
        }
    }
    
    func createUser(name: String,
                    email: String,
                    avatarName: String,
                    avatarColor: String,
                    completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        let headers = [
            "Authorization": "Bearer \(authToken)",
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        Alamofire.request(urlUserAdd,
                          method: .post,
                          parameters: body,
                          encoding: JSONEncoding.default,
                          headers: headers)
            .responseJSON { response in
                if response.result.error == nil {
                    guard let data = response.data else {
                        completion(false)
                        return
                    }
                    
                    let jsonDecoder = JSONDecoder()
                    guard let slackUser = try? jsonDecoder.decode(SlackUser.self, from: data) else {
                        completion(false)
                        return
                    }
                    
                    UserDataService.instance.userId = slackUser.userId
                    UserDataService.instance.avatarColor = slackUser.avatarColor
                    UserDataService.instance.avatarName = slackUser.avatarName
                    UserDataService.instance.email = slackUser.email
                    UserDataService.instance.name = slackUser.userName

                    completion(true)
                } else {
                    completion(false)
                    debugPrint(response.result.error as Any)
                }

        }
    }

}

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
                          headers: bearerHeaders)
            .responseJSON { response in
                if response.result.error == nil {
                    guard let data = response.data else {
                        completion(false)
                        return
                    }

                    guard let user = self.slackUser(fromData: data) else {
                        completion(false)
                        return
                    }

                    self.updateData(fromSlackUser: user)
                    completion(true)
                } else {
                    completion(false)
                    debugPrint(response.result.error as Any)
                }

        }
    }

    func findUser(completion: @escaping CompletionHandler) {
        let urlString = "\(urlUserByEmail)/\(userEmail)"
        Alamofire.request(urlString,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: bearerHeaders)
            .responseJSON { response in
                if response.result.error == nil {
                    guard let data = response.data,
                        let user = self.slackUser(fromData: data) else {
                        completion(false)
                        return
                    }
                    
                    self.updateData(fromSlackUser: user)
                    completion(true)
                } else {
                    completion(false)
                }
        }
    }
    
    func slackUser(fromData data: Data) -> SlackUser? {
        let jsonDecoder = JSONDecoder()
        guard let slackUser = try? jsonDecoder.decode(SlackUser.self, from: data) else {
            return nil
        }

        return slackUser
    }
    
    func updateData(fromSlackUser slackUser: SlackUser) {
        UserDataService.instance.userId = slackUser.userId
        UserDataService.instance.avatarColor = slackUser.avatarColor
        UserDataService.instance.avatarName = slackUser.avatarName
        UserDataService.instance.email = slackUser.email
        UserDataService.instance.name = slackUser.userName
    }
}

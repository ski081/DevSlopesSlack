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
        let headers = [
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(urlRegister,
                          method: .post,
                          parameters: body,
                          encoding: JSONEncoding.default,
                          headers: headers)
            .responseString { response in
                if response.result.error == nil {
                    completion(true)
                } else {
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
        }
    }
}

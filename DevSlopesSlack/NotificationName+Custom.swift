//
//  NotificationName+Custrom.swift
//  DevSlopesSlack
//
//  Created by Mark Struzinski on 3/30/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let presentModal = Notification.Name(rawValue: "presentModal")
    static let closeModal = Notification.Name(rawValue: "closeModal")
    static let userDataChanged = Notification.Name(rawValue: "userDataChanged")
}

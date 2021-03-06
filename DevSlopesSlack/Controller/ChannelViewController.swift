//
//  ChannelViewController.swift
//  DevSlopesSlack
//
//  Created by Mark Struzinski on 2/28/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import Cocoa

class ChannelViewController: NSViewController {
    @IBOutlet weak var userNameLabel: NSTextField!
    @IBOutlet weak var addChannelButton: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = chatPurple.cgColor
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(userDataDidChange(_:)),
                                               name: Notification.Name.userDataChanged,
                                               object: nil)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        setupView()
    }
    
    func setupView() {
        view.wantsLayer = true
        view.layer?.backgroundColor = chatPurple.cgColor
        
        addChannelButton.styleButtonText(withName: "Add +",
                                         fontColor: .controlColor,
                                         alignment: .center,
                                         font: avenirRegular,
                                         size: 13.0)
    }
    
    @IBAction func addChannelClicked(_ sender: NSButton) {
        
    }
    
    @objc
    func userDataDidChange(_ notification: Notification) {
        if AuthService.instance.isLoggedIn {
            userNameLabel.stringValue = UserDataService.instance.name
        } else {
            userNameLabel.stringValue = "<Not Logged In>"
        }
    }
}

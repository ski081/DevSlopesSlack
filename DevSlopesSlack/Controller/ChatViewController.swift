//
//  ChatViewController.swift
//  DevSlopesSlack
//
//  Created by Mark Struzinski on 2/28/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import Cocoa

class ChatViewController: NSViewController {
    @IBOutlet weak var channelTitle: NSTextField!
    @IBOutlet weak var channelDescription: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var typingUserLabel: NSTextField!
    @IBOutlet weak var messageOutlineView: NSTextField!
    @IBOutlet weak var messageText: NSTextFieldCell!
    @IBOutlet weak var sendMessageButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        view.layer?.backgroundColor = NSColor.init(named: NSColor.Name("bg-channel"))!.cgColor
        
        messageOutlineView.wantsLayer = true
        messageOutlineView.layer?.backgroundColor = .white
        messageOutlineView.layer?.borderColor = NSColor.controlHighlightColor.cgColor
        messageOutlineView.layer?.borderWidth = 2
        messageOutlineView.layer?.cornerRadius = 5
        
        sendMessageButton.styleButtonText(withName: "Send",
                                          fontColor: .white,
                                          alignment: .center,
                                          font: avenirRegular,
                                          size: 13.0)
    }
    
    @IBAction func sendMessageButtonClicked(_ sender: NSButton) {
        
    }
    
    @objc
    func userDataDidChange(_ notification: Notification) {
        if AuthService.instance.isLoggedIn {
        } else {

        }
    }

}

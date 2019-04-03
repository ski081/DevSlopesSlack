//
//  ModalLogin.swift
//  DevSlopesSlack
//
//  Created by Mark Struzinski on 3/30/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import Cocoa

class ModalLogin: NSView {
    @IBOutlet weak var view: NSView!
    @IBOutlet weak var userNameTextField: NSTextField!
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    @IBOutlet weak var loginButton: NSButton!
    @IBOutlet weak var createAccountButton: NSButton!
    @IBOutlet weak var stackView: NSStackView!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        Bundle.main.loadNibNamed(NSNib.Name("ModalLogin"),
                                 owner: self,
                                 topLevelObjects: nil)
        self.addSubview(self.view)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        setupView()
    }
    
    @IBAction func closeModalButtonClicked(_ sender: NSButton) {
        NotificationCenter.default.post(name: Notification.Name.closeModal,
                                        object: nil)
    }
    
    @IBAction func loginButtonClicked(_ sender: NSButton) {
    
    }
    
    @IBAction func createAccountButtonClicked(_ sender: NSButton) {
        let userInfo: [String: Bool] = [
            removeModalImmediately: true
        ]
        
        NotificationCenter.default.post(name: Notification.Name.closeModal,
                                        object: nil,
                                        userInfo: userInfo)
    }
    
    
    func setupView() {
        self.view.frame = NSRect(x: 0,
                                 y: 0,
                                 width: 475,
                                 height: 300)
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.init(named: NSColor.Name("bg-modal-form"))!.cgColor
        view.layer?.cornerRadius = 7
        
        loginButton.layer?.backgroundColor = NSColor.init(named: NSColor.Name("bg-channel"))!.cgColor
        loginButton.layer?.cornerRadius = 7
        loginButton.styleButtonText(withName: "Login",
                                    fontColor: .white,
                                    alignment: .center,
                                    font: avenirRegular,
                                    size: 14.0)
        createAccountButton.styleButtonText(withName: "Create Account",
                                            fontColor: chatGreen,
                                            alignment: .center,
                                            font: avenirRegular,
                                            size: 12.0)

    }
    
}

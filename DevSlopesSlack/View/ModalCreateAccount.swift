//
//  ModalCreateAccount.swift
//  DevSlopesSlack
//
//  Created by Mark Struzinski on 4/2/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import Cocoa

class ModalCreateAccount: NSView {
    @IBOutlet weak var view: NSView!
    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var emailTextField: NSTextField!
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    @IBOutlet weak var profileImageView: NSImageView!
    @IBOutlet weak var createAccountButton: NSButton!
    @IBOutlet weak var chooseImageButton: NSButton!
    @IBOutlet weak var progressSpinner: NSProgressIndicator!
    @IBOutlet weak var stackView: NSStackView!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        Bundle.main.loadNibNamed(NSNib.Name("ModalCreateAccount"),
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
    
    func setupView() {
        self.view.frame = NSRect(x: 0,
                                 y: 0,
                                 width: 475,
                                 height: 300)
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.init(named: NSColor.Name("bg-modal-form"))!.cgColor
        view.layer?.cornerRadius = 7
        
        profileImageView.layer?.cornerRadius = 10
        profileImageView.layer?.borderColor = NSColor.gray.cgColor
        profileImageView.layer?.borderWidth = 3
        
        createAccountButton.styleButtonText(withName: "Create Account",
                                            fontColor: .white,
                                            alignment: .center,
                                            font: avenirRegular,
                                            size: 13.0)
        chooseImageButton.styleButtonText(withName: "Choose Image",
                                          fontColor: .white,
                                          alignment: .center,
                                          font: avenirRegular,
                                          size: 13.0)
        createAccountButton.layer?.backgroundColor = chatGreen.cgColor
        createAccountButton.layer?.cornerRadius = 7
        
        chooseImageButton.layer?.backgroundColor = chatGreen.cgColor
        chooseImageButton.layer?.cornerRadius = 7
        
        nameTextField.focusRingType = .none
        emailTextField.focusRingType = .none
        passwordTextField.focusRingType = .none
    }
    
    @IBAction func closeButtonClicked(_ sender: NSButton) {
        NotificationCenter.default.post(name: Notification.Name.closeModal,
                                        object: nil)
    }
    
    @IBAction func createAccountButtonClicked(_ sender: NSButton) {
        let email = emailTextField.stringValue
        let password = passwordTextField.stringValue
        
        AuthService.instance.registerUser(email: email,
                                          password: password) { success in
                                            if success {
                                                self.loginUser(for: email,
                                                               password: password)
                                            } else {
                                                print("error")
                                            }
        }
    }
    
    @IBAction func chooseImageButtonClicked(_ sender: NSButton) {

    }
    
    func loginUser(for email: String, password: String) {
        AuthService.instance.loginUser(email: email, password: password) { success in
            if success {
                self.createUser(for: email,
                                password: password)
            } else {
                print("error")
            }

        }
    }
    
    func createUser(for email: String, password: String) {
        let name = self.nameTextField.stringValue
        let avatarName = ""
        AuthService.instance.createUser(name: name,
                                        email: email,
                                        avatarName: avatarName,
                                        avatarColor: "") { success in
                                            if success {
                                                let name = Notification.Name.closeModal
                                                NotificationCenter.default.post(name: name,
                                                                                object: nil)
                                            } else {
                                                print("error")
                                            }
        }
    }
}

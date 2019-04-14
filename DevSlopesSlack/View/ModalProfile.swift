//
//  ModalProfile.swift
//  DevSlopesSlack
//
//  Created by Mark Struzinski on 4/13/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import AppKit

class ModalProfile: NSView {
    @IBOutlet weak var view: NSView!
    @IBOutlet weak var userNameLabel: NSTextField!
    @IBOutlet weak var userEmailLabel: NSTextField!
    @IBOutlet weak var profileImageView: NSImageView!
    @IBOutlet weak var logoutButton: NSButton!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        Bundle.main.loadNibNamed(NSNib.Name("ModalProfile"),
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
        profileImageView.image = NSImage(named: NSImage.Name("boom"))
        
        logoutButton.layer?.backgroundColor = NSColor.init(named: NSColor.Name("bg-channel"))!.cgColor
        logoutButton.layer?.cornerRadius = 7
        logoutButton.styleButtonText(withName: "Logout",
                                     fontColor: .white,
                                     alignment: .center,
                                     font: avenirRegular,
                                     size: 14.0)
    }
}

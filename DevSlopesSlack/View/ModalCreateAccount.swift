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
    }
}

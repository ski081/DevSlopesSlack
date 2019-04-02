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
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        Bundle.main.loadNibNamed(NSNib.Name("ModalLogin"),
                                 owner: self,
                                 topLevelObjects: nil)
        self.view.frame = NSRect(x: 0, y: 0, width: 475, height: 300)
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
        view.wantsLayer = true
        view.layer?.backgroundColor = CGColor.white
        view.layer?.cornerRadius = 7
    }
    
}

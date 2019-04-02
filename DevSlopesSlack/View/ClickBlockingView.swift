//
//  ClickBlockingView.swift
//  DevSlopesSlack
//
//  Created by Mark Struzinski on 3/30/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import AppKit

class ClickBlockingView: NSView {
    override func mouseDown(with event: NSEvent) {}
    override func mouseUp(with event: NSEvent) {}
    override func mouseDragged(with event: NSEvent) {}
    override func mouseMoved(with event: NSEvent) {}
}

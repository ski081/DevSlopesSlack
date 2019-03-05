//
//  ToolBarViewController.swift
//  DevSlopesSlack
//
//  Created by Mark Struzinski on 2/28/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import Cocoa

class ToolBarViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = chatGreen.cgColor
    }
    
}

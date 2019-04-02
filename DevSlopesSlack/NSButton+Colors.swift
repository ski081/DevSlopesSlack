//
//  NSButton+Colors.swift
//  Weathered
//
//  Created by Mark Struzinski on 2/25/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import AppKit

extension NSButton {
    func styleButtonText(withName name: String,
                         fontColor: NSColor,
                         alignment: NSTextAlignment,
                         font: String,
                         size: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: fontColor,
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: NSFont(name: font, size: size)!
        ]
        
        self.attributedTitle = NSAttributedString(string: name,
                                                  attributes: attributes)
    }
}

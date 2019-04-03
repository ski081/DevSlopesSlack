//
//  ToolBarViewController.swift
//  DevSlopesSlack
//
//  Created by Mark Struzinski on 2/28/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import Cocoa

class ToolBarViewController: NSViewController {
    @IBOutlet weak var loginStackView: NSStackView!
    @IBOutlet weak var loginLabel: NSTextField!
    @IBOutlet weak var loginImageView: NSImageView!
    
    var modalBGView: ClickBlockingView!
    var modalView: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        setupView()
    }
    
    func setupView() {
        let notificationName = Notification.Name.presentModal
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(presentModal(_:)),
                                               name: notificationName,
                                               object: nil)
        view.wantsLayer = true
        view.layer?.backgroundColor = chatGreen.cgColor

        loginStackView.gestureRecognizers.removeAll()
        let profilePage = NSClickGestureRecognizer(target: self, action: #selector(ToolBarViewController.openProfilePage(_:)))
        loginStackView.addGestureRecognizer(profilePage)
    }
    
    @objc func openProfilePage(_ recognizer: NSClickGestureRecognizer) {
        let loginDict: [String: ModalType] = [
            userInfoModal: .login
        ]
        
        let notificationName = Notification.Name.presentModal
        NotificationCenter.default.post(name: notificationName,
                                        object: nil,
                                        userInfo: loginDict)
    }
    
    @objc
    func presentModal(_ notification: Notification) {
        var modalWidth: CGFloat = 0.0
        var modalHeight: CGFloat = 0.0
        
        if modalBGView == nil {
            modalBGView = ClickBlockingView()
            modalBGView.wantsLayer = true
            modalBGView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(modalBGView,
                            positioned: .above,
                            relativeTo: loginStackView)
            let topConstraint = NSLayoutConstraint(item: modalBGView!,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .top,
                                                   multiplier: 1.0,
                                                   constant: 50.0)
            let leftConstraint = NSLayoutConstraint(item: modalBGView!,
                                                    attribute: .left,
                                                    relatedBy: .equal,
                                                    toItem: view,
                                                    attribute: .left,
                                                    multiplier: 1.0,
                                                    constant: 0.0)
            let rightConstraint = NSLayoutConstraint(item: modalBGView!,
                                                     attribute: .right,
                                                     relatedBy: .equal,
                                                     toItem: view,
                                                     attribute: .right,
                                                     multiplier: 1.0,
                                                     constant: 0.0)
            let bottomConstraint = NSLayoutConstraint(item: modalBGView!,
                                                   attribute: .bottom,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .bottom,
                                                   multiplier: 1.0,
                                                   constant: 0.0)
            let constraints = [
                topConstraint,
                leftConstraint,
                bottomConstraint,
                rightConstraint
            ]
            
            view.addConstraints(constraints)
            modalBGView.layer?.backgroundColor = NSColor.init(named: NSColor.Name("bg-modal"))!.cgColor
            modalBGView.alphaValue = 0.0
            
            
            
            let closeBackgroundClickGestureRecognizer = NSClickGestureRecognizer(target: self,
                                                                                 action: #selector(closeModalClick(_:)))
            modalBGView.addGestureRecognizer(closeBackgroundClickGestureRecognizer)
            
            guard let modalType = notification.userInfo?[userInfoModal] as? ModalType else {
                return
            }
            
            switch modalType {
            case .login:
                modalView = ModalLogin()
                modalWidth = 475
                modalHeight = 300
            }
            
            modalView.wantsLayer = true
            modalView.translatesAutoresizingMaskIntoConstraints = false
            modalView.alphaValue = 0
            
            view.addSubview(modalView,
                            positioned: .above,
                            relativeTo: modalBGView)
            
            let horizontalContraint = modalView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            let verticalContraint = modalView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            let widthConstraint = modalView.widthAnchor.constraint(equalToConstant: modalWidth)
            let heightConstraint = modalView.heightAnchor.constraint(equalToConstant: modalHeight)
            
            let modalConstraints = [
                horizontalContraint,
                verticalContraint,
                widthConstraint,
                heightConstraint
            ]
            
            NSLayoutConstraint.activate(modalConstraints)
        }
        
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.5
            modalBGView.animator().alphaValue = 0.6
            modalView.animator().alphaValue = 1.0
            self.view.layoutSubtreeIfNeeded()
        }
    }
    
    @objc
    func closeModalClick(_ regognizer: NSClickGestureRecognizer) {
        closeModal()
    }
    
    func closeModal() {
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.5
            modalBGView.animator().alphaValue = 0.0
            modalView.animator().alphaValue = 0.0
            self.view.layoutSubtreeIfNeeded()
        }) {
            if self.modalBGView != nil {
                self.modalBGView.removeFromSuperview()
                self.modalBGView = nil
            }
            
            if self.modalView != nil {
                self.modalView.removeFromSuperview()
                self.modalView = nil
            }
        }
    }

}

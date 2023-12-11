//
//  AlertDelegate.swift
//
//
//  Created by Kai Shao on 2023/12/11.
//

import SwiftUI

public protocol AlertDelegate: AnyObject {
    var windowScene: UIWindowScene? { get }
    var overlayWindow: UIWindow? { get set }
    var tag: Int { get set }
    var alerts: [UIView] { get set }
    
    init()
    
    func removeFirstAlert()
    func removeAlert(withTag tag: Int)
}

public extension AlertDelegate {
    func setupOverlayWindow() {
        guard let windowScene = windowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        window.isHidden = true
        window.isUserInteractionEnabled = false
        
        self.overlayWindow = window
    }
}

extension AlertDelegate {
    func removeFirstAlert() {
        alerts.removeFirst()
    }
    
    func removeAlert(withTag tag: Int) {
        alerts.removeAll(where: { $0.tag == tag })
    }
    
    func alert<Content: View>(config: Binding<AlertConfiguration>, @ViewBuilder content: @escaping () -> Content, viewTag: @escaping (Int) -> ()) {
        guard let alertWindow = overlayWindow else { return }
        
        let viewController = UIHostingController(rootView:
                                                    AlertView(config: config, tag: tag, content: {
            content()
        })
        )
        viewController.view.backgroundColor = .clear
        viewController.view.tag = tag
        viewTag(tag)
        tag += 1
        
        if alertWindow.rootViewController == nil {
            alertWindow.rootViewController = viewController
            alertWindow.isHidden = false
            alertWindow.isUserInteractionEnabled = true
        } else {
            //print("Exisiting Alert is Still Present")
            viewController.view.frame = alertWindow.rootViewController?.view.frame ?? .zero
            alerts.append(viewController.view)
        }
    }
}

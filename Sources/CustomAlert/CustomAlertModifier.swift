//
//  AlertModifier.swift
//
//
//  Created by Kai Shao on 2023/12/11.
//

import SwiftUI

/// Alert Handling View Modifier
struct CustomAlertModifier<AlertContent: View>: ViewModifier {
    @Binding var config: AlertConfiguration
    @Environment(\.alertDelegate) var alertDelegate
    @ViewBuilder var alertContent: () -> AlertContent
    
    @State private var viewTag: Int = 0
    private var delegate: any AlertDelegate {
        alertDelegate!
    }
    
    func body(content: Content) -> some View {
        content
            .onChange(of: config.show, initial: false) { oldValue, newValue in
                if newValue {
                    /// Simply Call the Function we implemented on delegate
                    delegate.alert(config: $config, content: alertContent) { tag in
                        viewTag = tag
                    }
                } else {
                    guard let alertWindow = delegate.overlayWindow else { return }
                    if config.showView {
                        withAnimation(.smooth(duration: 0.35, extraBounce: 0)) {
                            config.showView = false
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                            if delegate.alerts.isEmpty {
                                alertWindow.rootViewController = nil
                                alertWindow.isHidden = true
                                alertWindow.isUserInteractionEnabled = false
                            } else {
                                /// Presenting Next Alert
                                if let first = delegate.alerts.first {
                                    /// Removing the Preview View
                                    alertWindow.rootViewController?.view.subviews.forEach({ view in
                                        view.removeFromSuperview()
                                    })
                                    
                                    alertWindow.rootViewController?.view.addSubview(first)
                                    /// Removing the Added alert from the Array
                                    delegate.removeFirstAlert()
                                }
                            }
                        }
                    } else {
                        //print("View is Not Appeared")
                        /// Removing the view from the Array with the help of View Tag
                        delegate.removeAlert(withTag: viewTag)
                    }
                }
            }
    }
}

//
//  AlertPresetModifier.swift
//
//
//  Created by Kai Shao on 2023/12/11.
//

import SwiftUI

struct AlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    var title: LocalizedStringKey
    var message: LocalizedStringKey?
    var actions: [AlertAction] = []
    var handleAction: ((AlertAction) async -> Void)?
    
    @State private var configuration: AlertConfiguration = .init()
    
    func body(content: Content) -> some View {
        content
            .customAlert(config: $configuration) {
                AlertBody(isPresented: $isPresented,
                          title: title,
                          message: message,
                          actions: actions,
                          handleAction: handleAction)
            }
            .onChange(of: isPresented, { oldValue, newValue in
                configuration.show = newValue
            })
    }
}

public extension View {
    func alert(isPresented: Binding<Bool>, title: LocalizedStringKey, message: LocalizedStringKey? = nil, actions: [AlertAction] = [.ok], handleAction: ((AlertAction) async -> Void)? = nil) -> some View {
        modifier(
            AlertModifier(isPresented: isPresented, 
                          title: title,
                          message: message,
                          actions: actions,
                          handleAction: handleAction)
        )
    }
}

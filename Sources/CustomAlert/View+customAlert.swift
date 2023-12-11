//
//  View+Alert.swift
//
//
//  Created by Kai Shao on 2023/12/11.
//

import SwiftUI

public extension View {
    @ViewBuilder
    func customAlert<Content: View>(config: Binding<AlertConfiguration>, @ViewBuilder content: @escaping () -> Content) -> some View {
        modifier(
            CustomAlertModifier(config: config, alertContent: content)
        )
    }
}

public extension EnvironmentValues {
    var alertDelegate: (any AlertDelegate)? {
        get { self[AlertDelegateKey.self].self }
        set { self[AlertDelegateKey.self] = newValue }
    }
}

private struct AlertDelegateKey: EnvironmentKey {
    static var defaultValue: (any AlertDelegate)?
}

//
//  View+Alert.swift
//
//
//  Created by Kai Shao on 2023/12/11.
//

import SwiftUI

public extension View {
    @ViewBuilder
    func alert<Content: View>(alertConfig: Binding<AlertConfiguration>, @ViewBuilder content: @escaping () -> Content) -> some View {
            modifier(
                AlertModifier(config: alertConfig, alertContent: content)
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

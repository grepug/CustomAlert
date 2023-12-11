//
//  AlertAction.swift
//
//
//  Created by Kai Shao on 2023/12/11.
//

import SwiftUI

public struct AlertAction: Identifiable {
    var text: LocalizedStringKey
    
    public var id: String
    
    public init(id: String = UUID().uuidString, text: LocalizedStringKey) {
        self.id = id
        self.text = text
    }
    
}

public extension AlertAction {
    static var ok: Self {
        .init(id: "ok", text: "ok")
    }
    
    static var cancel: Self {
        .init(id: "cancel", text: "cancel")
    }
}


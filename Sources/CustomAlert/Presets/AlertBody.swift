//
//  AlertBody.swift
//
//
//  Created by Kai Shao on 2023/12/11.
//

import SwiftUI

struct AlertBody: View {
    @Binding var isPresented: Bool
    var title: LocalizedStringKey
    var message: LocalizedStringKey?
    var actions: [AlertAction]
    var handleAction: ((AlertAction) async -> Void)?
    
    @State private var asyncButtonStates: [Bool] = []
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline.bold())
            
            if let message {
                Text(message)
            }
            
            VStack {
                ForEach(actions) { item in
                    if let handleAction {
                        AsyncButton(isPresented: $isPresented) {
                            await handleAction(item)
                        } label: {
                            actionButton(item: item)
                        }
                    } else {
                        Button {
                            isPresented = false
                        } label: {
                            actionButton(item: item)
                        }
                    }
                }
            }
        }
        .padding()
        .frame(minWidth: 300, minHeight: 180)
        .background(.ultraThickMaterial)
        .clipShape(.rect(cornerRadius: 24))
    }
    
    func actionButton(item: AlertAction) -> some View {
        Text(item.text)
    }
}

struct AsyncButton<Label: View>: View {
    @Binding var isPresented: Bool
    var action: () async -> Void
    @ViewBuilder var label: () -> Label
    
    @State private var isLoading = false
    
    var body: some View {
        Button {
            Task {
                isLoading = true
                await action()
                isLoading = false
                try? await Task.sleep(for: .seconds(0.3))
                isPresented = false
            }
        } label: {
            label()
                .overlay {
                    if isLoading {
                        ProgressView()
                    }
                }
        }
    }
}

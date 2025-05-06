//
//  ToastManager.swift
//  gamevault_project
//
//  Created by Tran Ba Minh Huy on 2025-04-13.
//

import Foundation
import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var message: String?

    func body(content: Content) -> some View {
        ZStack {
            content
            if let msg = message {
                VStack {
                    Spacer()
                    Text(msg)
                        .padding()
                        .background(Color.black.opacity(0.85))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.bottom, 50)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                .zIndex(1)
            }
        }
        .animation(.easeInOut, value: message)
    }
}

extension View {
    func toast(_ message: Binding<String?>) -> some View {
        self.modifier(ToastModifier(message: message))
    }
}

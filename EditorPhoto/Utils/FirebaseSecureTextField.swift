//
//  EntryField.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 13.05.2024.
//

import SwiftUI

struct FirebaseSecureTextField: View {
    
    var placeholder: String
    @Binding var text: String
    @Binding var showPassword: Bool
    
    var body: some View {
        if showPassword {
            FirebaseTextField(placeholder: placeholder, text: $text)
                .overlay(alignment: .trailing) {
                    Button(role: .cancel) {
                        withAnimation(.snappy) {
                            showPassword = false
                        }
                    } label: {
                        Image(systemName: "eye")
                            .padding()
                            .contentTransition(.symbolEffect)
                            .foregroundColor(.black)
                    }
                    .keyboardShortcut(.defaultAction)
                }
        } else {
            SecureField(placeholder, text: $text)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding()
                .foregroundColor(.primary)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.ultraThinMaterial)
                        .stroke(.primary, style: StrokeStyle(lineWidth: 1))
                )
                .overlay(alignment: .trailing) {
                    Button(role: .cancel){
                        withAnimation(.snappy) {
                            showPassword = true
                        }
                    } label: {
                        Image(systemName: "eye.slash")
                            .padding()
                            .contentTransition(.symbolEffect)
                            .foregroundColor(.black)
                    }
                    .keyboardShortcut(.defaultAction)
                }
        }
    }
}

#Preview {
    LoginView()
}

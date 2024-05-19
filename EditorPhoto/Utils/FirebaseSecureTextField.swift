//
//  EntryField.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 13.05.2024.
//

import SwiftUI

struct FirebaseSecureTextField: View {
    
    // MARK: Properties
    
    var placeholder: String
    @Binding var text: String
    @Binding var showPassword: Bool
    
    // MARK: Body
    
    var body: some View {
        if showPassword {
            notSecureTextField
        } else {
            secureTextField
        }
    }
    
    // MARK: Some Views
    
    private var secureTextField: some View {
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
                    closedEyeImage
                        .keyboardShortcut(.defaultAction)
                }
            }
    }
    
    private var notSecureTextField: some View {
        FirebaseTextField(placeholder: placeholder, text: $text)
            .overlay(alignment: .trailing) {
                Button(role: .cancel) {
                    withAnimation(.snappy) {
                        showPassword = false
                    }
                } label: {
                    openEyeImage
                }
                .keyboardShortcut(.defaultAction)
            }
    }
    
    private var openEyeImage: some View {
        Image(systemName: "eye")
            .padding()
            .contentTransition(.symbolEffect)
            .foregroundColor(.black)
    }
    
    private var closedEyeImage: some View {
        Image(systemName: "eye.slash")
            .padding()
            .contentTransition(.symbolEffect)
            .foregroundColor(.black)
    }
    
}

#Preview {
    LoginView()
}

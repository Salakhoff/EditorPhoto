//
//  ForgotPasswordView.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 14.05.2024.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    // MARK: Properties
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ForgotPasswordViewModel()
    
    // MARK: Body
    
    var body: some View {
        VStack {
            recoverPasswordText
            emailTextField
            recoverPasswordButton
        }
        .alert("error".localized,
               isPresented: $viewModel.isShowError) {
            Button {
                viewModel.isShowError = false
            } label: {
                Text("ok".localized)
            }
        } message: {
            Text(viewModel.localizedError)
        }
        
        .alert("successful".localized,
               isPresented: $viewModel.isSuccessfulCompletion) {
            Button {
                viewModel.isSuccessfulCompletion = false
                dismiss()
            } label: {
                Text("ok".localized)
            }
        } message: {
            Text("passwordRecoveryEmailSent".localized)
        }
        .padding()
    }
    
    // MARK: Some Views
    
    private var recoverPasswordText: some View {
        Text("recoverPassword".localized)
            .font(.title2)
            .bold()
    }
    
    private var emailTextField: some View {
        FirebaseTextField(
            placeholder: "emailAdress".localized,
            text: $viewModel.email
        )
        .textContentType(.emailAddress)
        .keyboardType(.emailAddress)
    }
    
    private var recoverPasswordButton: some View {
        Button {
            viewModel.forgotPassword()
        } label: {
            Text("recoverPassword".localized)
                .padding()
                .bold()
                .foregroundColor(.white)
                .padding()
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                )
        }
    }
}

#Preview {
    ForgotPasswordView()
}

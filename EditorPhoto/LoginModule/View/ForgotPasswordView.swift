//
//  ForgotPasswordView.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 14.05.2024.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = ForgotPasswordViewModel()
    
    var body: some View {
        VStack {
            Text("recoverPassword".localized)
                .font(.title2)
                .bold()
            
            FirebaseTextField(
                placeholder: "emailAdress".localized,
                text: $viewModel.email
            )
            .textContentType(.emailAddress)
            .keyboardType(.emailAddress)
            
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
}

#Preview {
    ForgotPasswordView()
}

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
            Text("Восстановить пароль")
                .font(.title2)
                .bold()
            
            FirebaseTextField(
                placeholder: "Эл.почта",
                text: $viewModel.email
            )
            .textContentType(.emailAddress)
            .keyboardType(.emailAddress)
            
            Button {
                viewModel.forgotPassword()
            } label: {
                Text("Восстановить пароль")
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
        .alert("Ошибка!",
               isPresented: $viewModel.isShowError) {
            Button {
                viewModel.isShowError = false
            } label: {
                Text("OK")
            }
        } message: {
            Text(viewModel.localizedError)
        }
        .alert("Успешно!",
               isPresented: $viewModel.isSuccessfulCompletion) {
            Button {
                viewModel.isSuccessfulCompletion = false
                dismiss()
            } label: {
                Text("OK")
            }
        } message: {
            Text("Письмо для восстановления пароля было отправлено на вашу электронную почту.")
        }
        .padding()
    }
}

#Preview {
    ForgotPasswordView()
}

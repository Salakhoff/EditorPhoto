//
//  ForgotPasswordView.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 14.05.2024.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            Text("Восстановить пароль")
                .font(.title2)
                .bold()
            
            FirebaseTextField(
                placeholder: "Эл.почта",
                text: $viewModel.resetPassword
            )
            .textContentType(.emailAddress)
            .keyboardType(.emailAddress)
            
            Button {
                viewModel.forgotPassword()
                viewModel.isShowResetPassword = false
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
        .padding()
    }
}

#Preview {
    ForgotPasswordView(viewModel: LoginViewModel())
}

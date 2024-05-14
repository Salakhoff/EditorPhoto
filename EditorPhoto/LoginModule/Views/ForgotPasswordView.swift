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
            HStack {
                Text("Восстановить пароль")
                    .font(.title2)
                    .bold()
                
                Spacer()
                
                Button(role: .cancel) {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle")
                        .imageScale(.large)
                        .foregroundColor(Color(uiColor: .label))
                }
            }
            
            FirebaseTextField(
                placeholder: "Эл.почта",
                text: $viewModel.resetPassword
            )
            
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

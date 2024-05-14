//
//  RegistView.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 14.05.2024.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = RegisterViewModel()
    
    var body: some View {
        VStack {
            Text("Создать новый аккаунт")
                .font(.title2)
                .bold()
    
            FirebaseTextField(
                placeholder: "Эл.почта",
                text: $viewModel.email
            )
            .textContentType(.emailAddress)
            .keyboardType(.emailAddress)
            
            FirebaseSecureTextField(
                placeholder: "Пароль",
                text: $viewModel.password,
                showPassword: $viewModel.isShowPassword
            )
            
            FirebaseSecureTextField(
                placeholder: "Повторите пароль",
                text: $viewModel.passwordCheck,
                showPassword: $viewModel.isShowPasswordCheck
            )
            
            Button {
                viewModel.registerWithEmail()
            } label: {
                Text("Зарегистрироваться")
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
    }
}

#Preview {
    RegisterView()
}

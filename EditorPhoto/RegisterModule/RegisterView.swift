//
//  RegistView.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 14.05.2024.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @FocusState private var focus: FocusableField?
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
            .submitLabel(.next)
            .focused($focus, equals: .email)
            .onSubmit {
                focus = .password
            }
            
            FirebaseSecureTextField(
                placeholder: "Пароль",
                text: $viewModel.password,
                showPassword: $viewModel.isShowPassword
            )
            .submitLabel(.next)
            .focused($focus, equals: .password)
            .onSubmit {
                focus = .passwordCheck
            }
            
            FirebaseSecureTextField(
                placeholder: "Повторите пароль",
                text: $viewModel.passwordCheck,
                showPassword: $viewModel.isShowPasswordCheck
            )
            .submitLabel(.done)
            .focused($focus, equals: .passwordCheck)
            
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
        .alert("Отлично!",
               isPresented: $viewModel.isSuccessfulCompletion) {
            Button {
                viewModel.isSuccessfulCompletion = false
                dismiss()
            } label: {
                Text("OK")
            }
        } message: {
            Text("Регистрация прошла успешно.")
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
    }
}

#Preview {
    RegisterView()
}

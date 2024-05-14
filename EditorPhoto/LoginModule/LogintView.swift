//
//  ContentView.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 13.05.2024.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    @FocusState private var focus: FocusableField?
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFill()
                .overlay {
                    LinearGradient(
                        gradient: Gradient(
                            colors: [.white, .clear, .white]
                        ),
                        startPoint: .bottom, endPoint: .top
                    )
                }
            
            Spacer()
            
            VStack {
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
                .focused($focus, equals: .password)
                .submitLabel(.done)
                
                Button("Забыли пароль?") {
                    viewModel.isShowResetPassword = true
                    
                }
                .foregroundColor(.black)
                .bold()
                .padding(.vertical)
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Button(role: .destructive) {
                    viewModel.signInWithEmail()
                } label: {
                    Text("Войти")
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
            
            Spacer()
            
            VStack {
                Text("У вас нет аккаунта?")
                Button(role: .destructive) {
                    viewModel.isShowRegistration = true
                } label: {
                    Text("Зарегистрироваться")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
            .sheet(isPresented: $viewModel.isShowRegistration) {
                RegisterView()
            }
            .sheet(isPresented: $viewModel.isShowResetPassword) {
                ForgotPasswordView()
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
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, 60)
    }
}

#Preview {
    LoginView()
}

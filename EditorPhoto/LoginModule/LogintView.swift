//
//  ContentView.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 13.05.2024.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFill()
                .overlay {
                    LinearGradient(
                        gradient: Gradient(
                            colors: [.white, .clear]
                        ),
                        startPoint: .bottom, endPoint: .top
                    )
                }
                .frame(height: 120)
            
            Spacer()
            
            VStack {
                FirebaseTextField(
                    placeholder: "Эл.почта",
                    text: $viewModel.email
                )
                
                FirebaseSecureTextField(
                    placeholder: "Пароль",
                    text: $viewModel.password,
                    showPassword: $viewModel.isShowPassword
                )
                
                Button("Забыли пароль?") {
                    viewModel.isShowResetPassword = true
                }
                .foregroundColor(.black)
                .bold()
                .padding(.vertical)
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Button("Войти") {
                    viewModel.signInWithEmail()
                }
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
            .padding()
            
            Spacer()
            
            VStack {
                Text("У вас нет аккаунта?")
                Button("Зарегистрироваться") {
                    viewModel.isShowRegistration = true
                }
                .bold()
                .foregroundColor(.black)
                .padding()
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.ultraThinMaterial)
                        .stroke(
                            .primary,
                            style: StrokeStyle(lineWidth: 1)
                        )
                )
            }
            .padding(.horizontal)
            .padding(.bottom)
            .sheet(isPresented: $viewModel.isShowRegistration) {
                RegisterView()
                    .presentationDetents([.fraction(0.5)])
            }
            .sheet(isPresented: $viewModel.isShowResetPassword) {
                ForgotPasswordView(viewModel: viewModel)
                    .presentationDetents([.fraction(0.3)])
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

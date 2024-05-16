//
//  ContentView.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 13.05.2024.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: Properties
    
    @StateObject var viewModel = LoginViewModel()
    @FocusState private var focus: FocusableField?
    
    // MARK: Body
    
    var body: some View {
        VStack {
            logo
            
            Spacer()
            
            VStack {
                emailAdressTextField
                passwordTextField
                forgotPasswordButton
                logInButton
            }
            .padding()
            
            Spacer()
            
            VStack {
                Text("noAccount".localized)
                registerButton
            }
            .padding([.horizontal, .bottom])
            .sheet(isPresented: $viewModel.isShowRegistration) {
                RegisterView()
            }
            
            .sheet(isPresented: $viewModel.isShowResetPassword) {
                ForgotPasswordView()
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
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, 60)
    }
    
    // MARK: Some Views
    
    private var logo: some View {
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
    }
    
    private var emailAdressTextField: some View {
        FirebaseTextField(
            placeholder: "emailAdress".localized,
            text: $viewModel.email
        )
        .textContentType(.emailAddress)
        .keyboardType(.emailAddress)
        .submitLabel(.next)
        .focused($focus, equals: .email)
        .onSubmit {
            focus = .password
        }
    }
    
    private var passwordTextField: some View {
        FirebaseSecureTextField(
            placeholder: "password".localized,
            text: $viewModel.password,
            showPassword: $viewModel.isShowPassword
        )
        .focused($focus, equals: .password)
        .submitLabel(.done)
    }
    
    private var forgotPasswordButton: some View {
        Button("forgotPassword".localized) {
            viewModel.isShowResetPassword = true
        }
        .foregroundColor(.black)
        .bold()
        .padding(.vertical)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    private var logInButton: some View {
        Button(role: .destructive) {
            viewModel.signInWithEmail()
        } label: {
            Text("logIn".localized)
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
    
    private var registerButton: some View {
        Button(role: .destructive) {
            viewModel.isShowRegistration = true
        } label: {
            Text("register".localized)
                .fontWeight(.semibold)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    LoginView()
}

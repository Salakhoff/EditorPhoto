//
//  RegistView.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 14.05.2024.
//

import SwiftUI

struct RegisterView: View {
    
    // MARK: Properties
    
    @Environment(\.dismiss) var dismiss
    @FocusState private var focus: FocusableField?
    @StateObject var viewModel = RegisterViewModel()
    
    // MARK: Body
    
    var body: some View {
        VStack {
            createNewAccountText
            emailTextField
            passwordTextField
            replayPasswordTextField
            registerButton
        }
        .padding()
        
        .alert("great".localized,
               isPresented: $viewModel.isSuccessfulCompletion) {
            Button {
                viewModel.isSuccessfulCompletion = false
                dismiss()
            } label: {
                Text("ok".localized)
            }
        } message: {
            Text("registrationSuccessful".localized)
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
    
    // MARK: Some Views
    
    private var createNewAccountText: some View {
        Text("createNewAccount".localized)
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
        .submitLabel(.next)
        .focused($focus, equals: .email)
        .onSubmit { focus = .password }
    }
    
    private var passwordTextField: some View {
        FirebaseSecureTextField(
            placeholder: "password".localized,
            text: $viewModel.password,
            showPassword: $viewModel.isShowPassword
        )
        .submitLabel(.next)
        .focused($focus, equals: .password)
        .onSubmit { focus = .passwordCheck }
    }
    
    private var replayPasswordTextField: some View {
        FirebaseSecureTextField(
            placeholder: "replayPasssword".localized,
            text: $viewModel.passwordCheck,
            showPassword: $viewModel.isShowPasswordCheck
        )
        .submitLabel(.done)
        .focused($focus, equals: .passwordCheck)
    }
    
    private var registerButton: some View {
        Button {
            viewModel.registerWithEmail()
        } label: {
            Text("register".localized)
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

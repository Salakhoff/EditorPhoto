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
            Text("createNewAccount".localized)
                .font(.title2)
                .bold()
            
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
            
            FirebaseSecureTextField(
                placeholder: "password".localized,
                text: $viewModel.password,
                showPassword: $viewModel.isShowPassword
            )
            .submitLabel(.next)
            .focused($focus, equals: .password)
            .onSubmit {
                focus = .passwordCheck
            }
            
            FirebaseSecureTextField(
                placeholder: "replayPasssword".localized,
                text: $viewModel.passwordCheck,
                showPassword: $viewModel.isShowPasswordCheck
            )
            .submitLabel(.done)
            .focused($focus, equals: .passwordCheck)
            
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
}

#Preview {
    RegisterView()
}

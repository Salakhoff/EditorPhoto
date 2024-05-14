//
//  RegisterViewModel.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 14.05.2024.
//

import Foundation

final class RegisterViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isShowPassword = false
    @Published var passwordCheck = ""
    @Published var isShowPasswordCheck = false
    @Published var isShowError = false
    var localizedError: String = ""
    
    func registerWithEmail() {
        Task {
            do {
                try await AuthService.shared.registerWithEmail(
                    email: email,
                    password: password
                )
            } catch let error as AppAuthError {
                isShowError = true
                localizedError = error.localizedDescription
            } catch {
                isShowError = true
                print(error.localizedDescription)
            }
        }
    }
    
    func validateForm() throws {
        if !email.isValidEmail() {
            throw AppAuthError.invalidEmail
        } else if !password.isValidPassword() || !passwordCheck.isValidPassword() {
            throw AppAuthError.invalidPassword
        } else if password != passwordCheck {
            throw AppAuthError.passwordDoNotMatch
        }
    }
}

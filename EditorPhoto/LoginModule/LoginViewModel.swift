//
//  LoginViewModel.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 13.05.2024.
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    // MARK: Published
    
    @Published var email = ""
    @Published var password = ""
    @Published var resetPassword = ""
    @Published var isShowPassword = false
    @Published var isShowRegistration = false
    @Published var isShowResetPassword = false
    @Published var isShowError = false
    var localizedError = ""
    
    // MARK: - Methods
    
    func validateLoginForm() throws {
        if !email.isValidEmail() {
            throw AppAuthError.invalidEmail
        } else if !password.isValidPassword() {
            throw AppAuthError.invalidPassword
        }
    }
    
    func validateForgotPasswordForm() throws {
        if !resetPassword.isValidEmail() {
            throw AppAuthError.invalidEmail
        }
    }
    
    func signInWithEmail() {
        Task {
            do {
                try await AuthService.shared.signInWithEmail(
                    email: email,
                    password: password
                )
            } catch let error as AppAuthError {
                isShowError = true
                localizedError = error.localizedDescription
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func forgotPassword() {
        Task {
            do {
                try validateForgotPasswordForm()
                try await AuthService.shared.resetPassword(
                    email: resetPassword
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
}

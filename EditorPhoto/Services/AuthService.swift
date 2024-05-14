//
//  AuthService.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 13.05.2024.
//

import Foundation
import FirebaseAuth

@Observable final class AuthService {
    
    static let shared = AuthService()
    
    var currentUser: FirebaseAuth.User?
    
    private let auth = Auth.auth()
    private init() {
        currentUser = auth.currentUser
    }
    
    func registerWithEmail(email: String, password: String) async throws {
        do {
            try await auth.createUser(withEmail: email, password: password)
            currentUser = nil
        } catch {
            let error = error as NSError
            switch error.code {
            case AuthErrorCode.emailAlreadyInUse.rawValue:
                throw AppAuthError.emailAlreadyInUse
            case AuthErrorCode.invalidEmail.rawValue:
                throw AppAuthError.invalidEmail
            case AuthErrorCode.wrongPassword.rawValue:
                throw AppAuthError.wrongPassword
            case AuthErrorCode.tooManyRequests.rawValue:
                throw AppAuthError.tooManyRequests
            case AuthErrorCode.userNotFound.rawValue:
                throw AppAuthError.userNotFound
            case AuthErrorCode.networkError.rawValue:
                throw AppAuthError.networkError
            default:
                throw AppAuthError.networkError
            }
        }
    }
    
    func signInWithEmail(email: String, password: String) async throws {
        do {
            let result = try await auth.signIn(withEmail: email, password: password)
            currentUser = result.user
        } catch {
            let error = error as NSError
            switch error.code {
            case AuthErrorCode.emailAlreadyInUse.rawValue:
                throw AppAuthError.emailAlreadyInUse
            case AuthErrorCode.invalidEmail.rawValue:
                throw AppAuthError.invalidEmail
            case AuthErrorCode.wrongPassword.rawValue:
                throw AppAuthError.wrongPassword
            case AuthErrorCode.tooManyRequests.rawValue:
                throw AppAuthError.tooManyRequests
            case AuthErrorCode.userNotFound.rawValue:
                throw AppAuthError.userNotFound
            case AuthErrorCode.networkError.rawValue:
                throw AppAuthError.networkError
            default:
                throw AppAuthError.networkError
            }
        }
    }
    
    func signOut() throws {
        try auth.signOut()
        currentUser = nil
    }
    
    func resetPassword(email: String) async throws {
        do {
            try await auth.sendPasswordReset(withEmail: email)
        } catch {
            let error = error as NSError
            switch error.code {
            case AuthErrorCode.emailAlreadyInUse.rawValue:
                throw AppAuthError.emailAlreadyInUse
            case AuthErrorCode.invalidEmail.rawValue:
                throw AppAuthError.invalidEmail
            case AuthErrorCode.wrongPassword.rawValue:
                throw AppAuthError.wrongPassword
            case AuthErrorCode.tooManyRequests.rawValue:
                throw AppAuthError.tooManyRequests
            case AuthErrorCode.userNotFound.rawValue:
                throw AppAuthError.userNotFound
            case AuthErrorCode.networkError.rawValue:
                throw AppAuthError.networkError
            default:
                throw AppAuthError.networkError
            }
        }
    }
}

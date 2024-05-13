//
//  AuthService.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 13.05.2024.
//

import Foundation
import FirebaseAuth

final class AuthService {
    
    static let shared = AuthService()
    
    private init() {}
    
    private let auth = Auth.auth()
    
    func registerWithEmail(email: String, password: String) async throws {
        let result = try await auth.createUser(withEmail: email, password: password)
        print(result.user)
    }
    
    func signInWithEmail(email: String, password: String) async throws {
        let result = try await auth.signIn(withEmail: email, password: password)
        print(result.user)
    }
}

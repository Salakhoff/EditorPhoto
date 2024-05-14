//
//  AuthService.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 13.05.2024.
//

import Foundation
import FirebaseAuth
import Combine

@Observable
final class AuthService {
    
    static let shared = AuthService()
    
    var currentUser: FirebaseAuth.User?
    
    private let auth = Auth.auth()
    private init() {
        currentUser = auth.currentUser
    }
    
    func registerWithEmail(email: String, password: String) -> AnyPublisher<Void, Error> {
        return Future { [weak self] promise in
            guard let self else { return }
            Task {
                do {
                    try await self.auth.createUser(withEmail: email, password: password)
                    self.currentUser = nil
                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func signInWithEmail(email: String, password: String) -> AnyPublisher<Void, Error> {
        return Future { [weak self] promise in
            guard let self else { return }
            Task {
                do {
                    let result = try await self.auth.signIn(withEmail: email, password: password)
                    self.currentUser = result.user
                    
                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func signOut() -> AnyPublisher<Void, Error> {
        return Future { promise in
            do {
                try self.auth.signOut()
                self.currentUser = nil
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func resetPassword(email: String) -> AnyPublisher<Void, Error> {
        return Future { [weak self] promise in
            guard let self else { return }
            Task {
                do {
                    try await self.auth.sendPasswordReset(withEmail: email)
                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

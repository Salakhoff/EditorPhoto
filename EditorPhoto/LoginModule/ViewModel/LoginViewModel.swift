//
//  LoginViewModel.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 13.05.2024.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    // MARK: Published
    
    @Published var email = ""
    @Published var password = ""
    @Published var isShowPassword = false
    @Published var isShowRegistration = false
    @Published var isShowResetPassword = false
    @Published var isShowError = false
    @Published var localizedError = ""
    
    // MARK: Private Properties
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: Init
    
    init() {
        isFormValidPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    self.isShowError = true
                    self.localizedError = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(
            $email,
            $password
        )
        .map { email, password in
            return email.isValidEmail() && password.isValidPassword()
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: - Methods
    
    func validateLoginForm() -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { [weak self] promise in
            guard let self else { return }
            if !self.email.isValidEmail() {
                promise(.failure(AppAuthError.invalidEmail))
            } else if !self.password.isValidPassword() {
                promise(.failure(AppAuthError.invalidPassword))
            } else {
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func signInWithEmail() {
        validateLoginForm()
            .flatMap { _ in
                AuthService.shared.signInWithEmail(email: self.email, password: self.password)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    if let authError = error as? AppAuthError {
                        self.localizedError = authError.localizedDescription
                    } else {
                        self.localizedError = error.localizedDescription
                    }
                    self.isShowError = true
                case .finished:
                    break
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    deinit {
        print("LoginViewModel DELETED")
    }
}

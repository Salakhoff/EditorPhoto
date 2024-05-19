//
//  RegisterViewModel.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 14.05.2024.
//

import Foundation
import Combine

final class RegisterViewModel: ObservableObject {
    
    // MARK: Published
    
    @Published var email = ""
    @Published var password = ""
    @Published var passwordCheck = ""
    @Published var localizedError: String = ""
    @Published var isShowPassword = false
    @Published var isShowPasswordCheck = false
    @Published var isShowError = false
    @Published var isSuccessfulCompletion = false
    
    // MARK: Private Properties
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: Init
    
    init() {
        isFormValidPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.localizedError = error.localizedDescription
                    self.isShowError = true
                case .finished:
                    break
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(
            $email,
            $password,
            $passwordCheck
        )
        .map { email, password, passwordCheck in
            email.isValidEmail() &&
            password.isValidPassword() &&
            passwordCheck == password
        }
        .eraseToAnyPublisher()
    }
    
    func registerWithEmail() {
        validateForm()
            .flatMap { _ in
                AuthService.shared.registerWithEmail(email: self.email, password: self.password)
            }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    if let authError = error as? AppAuthError {
                        self.localizedError = authError.localizedDescription
                    } else {
                        self.localizedError = error.localizedDescription
                    }
                    self.isShowError = true
                case .finished:
                    self.isSuccessfulCompletion = true
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    func validateForm() -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { [weak self] promise in
            guard let self else { return }
            if !email.isValidEmail() {
                promise(.failure(AppAuthError.invalidEmail))
            } else if !password.isValidPassword() || !passwordCheck.isValidPassword() {
                promise(.failure(AppAuthError.invalidPassword))
            } else if password != passwordCheck {
                promise(.failure(AppAuthError.passwordDoNotMatch))
            } else {
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
}

//
//  RegisterViewModel.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 14.05.2024.
//

import Foundation
import Combine
import Firebase

class ForgotPasswordViewModel: ObservableObject {
    
    // MARK: Published
    
    @Published var email = ""
    @Published var isSuccessfulCompletion = false
    @Published var isShowError = false
    @Published var localizedError: String = ""
    
    // MARK: Private Properties
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: Init
    
    init() {
        isFormValidPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self]completion in
                guard let self else { return }
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
        $email
            .map { $0.isValidEmail() }
            .eraseToAnyPublisher()
    }
    
    func forgotPassword() {
        validateForgotPasswordForm()
            .flatMap { _ in
                AuthService.shared.resetPassword(email: self.email)
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
                    self.isSuccessfulCompletion = true
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    func validateForgotPasswordForm() -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            if !self.email.isValidEmail() {
                promise(.failure(AppAuthError.invalidEmail))
            } else {
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
    
    deinit {
        print("ForgotPasswordViewModel DELETED")
    }
}

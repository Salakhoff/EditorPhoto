//
//  RegisterViewModel.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 14.05.2024.
//

import Foundation
import Combine

final class ForgotPasswordViewModel: ObservableObject {
    
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
            .sink { completion in
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
        $email
            .map { $0.isValidEmail() }
            .eraseToAnyPublisher()
    }
    
    func forgotPassword() {
        validateForgotPasswordForm()
            .flatMap { _ in
                AuthService.shared.resetPassword(email: self.email)
            }
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.isShowError = true
                    self.localizedError = error.localizedDescription
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
}

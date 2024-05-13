//
//  LoginViewModel.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 13.05.2024.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    
    // MARK: Published
    
    @Published var email = ""
    @Published var password = ""
    @Published var isShowPassword = false
    @Published var isShowingPasswordReset = false
    @Published var isEmailValid = false
    @Published var isPasswordValid = false
    @Published var canSubmit = false
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        $email
            .map { $0.isValidEmail() }
            .assign(to: \.isEmailValid, on: self)
            .store(in: &cancellables)
        
        $password
            .map { $0.isValidPassword() }
            .assign(to: \.isPasswordValid, on: self)
            .store(in: &cancellables)
        
        Publishers.CombineLatest($isEmailValid, $isPasswordValid)
            .map { isEmailValid, isPasswordValid in
                return (isEmailValid && isPasswordValid)
            }
            .assign(to: \.canSubmit, on: self)
            .store(in: &cancellables)
    }
    
    var conformEmail: String {
        return isEmailValid ?
        ""
        :
        "Введите корректный адрес электронной почты"
    }
    
    var conformPassword: String {
        return isPasswordValid ?
        ""
        :
        "Пароль содержать минимум 8 символов, включая хотя бы 1 заглавную букву, 1 строчную букву, 1 цифру и 1 специальный символ."
    }
    
    func login() {
        print("Пробуем войти")
        email = ""
        password = ""
    }
    
    func resetPassword() {
        print("Восстановим пароль")
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailPredicate = NSPredicate(
            format: "SELF MATCHES %@",
            "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        )
        return emailPredicate.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}")
        return passwordPredicate.evaluate(with: self)
    }
}

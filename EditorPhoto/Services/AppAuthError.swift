//
//  AppAuthError.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 14.05.2024.
//

import Foundation

enum AppAuthError: Error {
    case emailAlreadyInUse
    case invalidEmail
    case invalidPassword
    case wrongPassword
    case tooManyRequests
    case userNotFound
    case networkError
    case passwordDoNotMatch
    
    var localizedDescription: String {
        switch self {
        case .emailAlreadyInUse:
            "Этот email уже используется"
        case .invalidEmail:
            "Неверный формат email. Проверьте еще раз"
        case .invalidPassword:
            "Неверный формат пароля. Пароли должны содержать не менее 8-ми символов, в том числе цифры, прописаные и строчные буквы, символы"
        case .wrongPassword:
            "Неверный пароль"
        case .tooManyRequests:
            "Слишком много запросов, попробуйте позже"
        case .userNotFound:
            "Пользователь не найден"
        case .networkError:
            "Ошибка сети. Попробуйте позже."
        case .passwordDoNotMatch:
            "Пароли не совпадают. Попробуйте еще раз"
        }
    }
}

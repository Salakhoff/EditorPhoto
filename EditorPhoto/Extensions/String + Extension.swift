//
//  String + Extension.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 14.05.2024.
//

import Foundation

extension String {
    /// Валидация на mail
    /// - Returns: проверка на точку и @
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    /// Валидация на password
    /// - Returns: должно вернуться 8 символов. Минимум 1 буква.
    func isValidPassword() -> Bool {
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$")
        return passwordPredicate.evaluate(with: self)
    }
    
    /// Для локализации
    var localized: String {
        NSLocalizedString(
            self, 
            comment: "\(self) could not be found in Localizable.strings"
        )
    }
}

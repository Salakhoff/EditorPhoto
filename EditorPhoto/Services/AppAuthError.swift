//
//  AppAuthError.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 14.05.2024.
//

import Foundation

enum AppAuthError: Error {
    case invalidCustomToken
    case customTokenMismatch
    case invalidCredential
    case userDisabled
    case operationNotAllowed
    case emailAlreadyInUse
    case invalidEmail
    case wrongPassword
    case tooManyRequests
    case userNotFound
    case accountExistsWithDifferentCredential
    case requiresRecentLogin
    case providerAlreadyLinked
    case noSuchProvider
    case invalidUserToken
    case networkError
    case userTokenExpired
    case invalidAPIKey
    case userMismatch
    case credentialAlreadyInUse
    case weakPassword
    case appNotAuthorized
    case expiredActionCode
    case invalidActionCode
    case invalidMessagePayload
    case invalidSender
    case invalidRecipientEmail
    case missingEmail
    case missingIosBundleID
    case missingAndroidPackageName
    case unauthorizedDomain
    case invalidContinueURI
    case missingContinueURI
    case missingPhoneNumber
    case invalidPhoneNumber
    case missingVerificationCode
    case invalidVerificationCode
    case missingVerificationID
    case invalidVerificationID
    case missingAppCredential
    case invalidAppCredential
    case sessionExpired
    case quotaExceeded
    case missingAppToken
    case notificationNotForwarded
    case appNotVerified
    case captchaCheckFailed
    case webContextAlreadyPresented
    case webContextCancelled
    case appVerificationUserInteractionFailure
    case invalidClientID
    case webNetworkRequestFailed
    case webInternalError
    case webSignInUserInteractionFailure
    case localPlayerNotAuthenticated
    case nullUser
    case dynamicLinkNotActivated
    case invalidProviderID
    case tenantIDMismatch
    case unsupportedTenantOperation
    case invalidDynamicLinkDomain
    case rejectedCredential
    case gameKitNotLinked
    case secondFactorRequired
    case missingMultiFactorSession
    case missingMultiFactorInfo
    case invalidMultiFactorSession
    case multiFactorInfoNotFound
    case adminRestrictedOperation
    case unverifiedEmail
    case secondFactorAlreadyEnrolled
    case maximumSecondFactorCountExceeded
    case unsupportedFirstFactor
    case emailChangeNeedsVerification
    case missingClientIdentifier
    case missingOrInvalidNonce
    case blockingCloudFunctionError
    case invalidPassword
    case passwordDoNotMatch
    
    var localizedDescription: String {
        switch self {
        case .invalidCustomToken:
            return "Неверный пользовательский токен."
        case .customTokenMismatch:
            return "Несоответствие пользовательского токена."
        case .invalidCredential:
            return "Неверные учетные данные."
        case .userDisabled:
            return "Пользователь отключен."
        case .operationNotAllowed:
            return "Операция не разрешена."
        case .emailAlreadyInUse:
            return "Электронная почта уже используется."
        case .invalidEmail:
            return "Неверный адрес электронной почты."
        case .wrongPassword:
            return "Неверный пароль."
        case .tooManyRequests:
            return "Слишком много запросов."
        case .userNotFound:
            return "Пользователь не найден."
        case .accountExistsWithDifferentCredential:
            return "Учетная запись с другими учетными данными уже существует."
        case .requiresRecentLogin:
            return "Требуется повторная аутентификация."
        case .providerAlreadyLinked:
            return "Поставщик уже связан с аккаунтом."
        case .noSuchProvider:
            return "Поставщик не найден."
        case .invalidUserToken:
            return "Неверный пользовательский токен."
        case .networkError:
            return "Сетевая ошибка."
        case .userTokenExpired:
            return "Срок действия пользовательского токена истек."
        case .invalidAPIKey:
            return "Неверный API-ключ."
        case .userMismatch:
            return "Несоответствие пользователей."
        case .credentialAlreadyInUse:
            return "Учетные данные уже используются."
        case .weakPassword:
            return "Слабый пароль."
        case .appNotAuthorized:
            return "Приложение не авторизовано."
        case .expiredActionCode:
            return "Срок действия кода истек."
        case .invalidActionCode:
            return "Неверный код действия."
        case .invalidMessagePayload:
            return "Неверная структура сообщения."
        case .invalidSender:
            return "Неверный отправитель."
        case .invalidRecipientEmail:
            return "Неверный адрес получателя электронной почты."
        case .missingEmail:
            return "Отсутствует адрес электронной почты."
        case .missingIosBundleID:
            return "Отсутствует идентификатор пакета iOS."
        case .missingAndroidPackageName:
            return "Отсутствует название пакета Android."
        case .unauthorizedDomain:
            return "Неавторизованный домен."
        case .invalidContinueURI:
            return "Неверный URI продолжения."
        case .missingContinueURI:
            return "Отсутствует URI продолжения."
        case .missingPhoneNumber:
            return "Отсутствует номер телефона."
        case .invalidPhoneNumber:
            return "Неверный номер телефона."
        case .missingVerificationCode:
            return "Отсутствует код проверки."
        case .invalidVerificationCode:
            return "Неверный код проверки."
        case .missingVerificationID:
            return "Отсутствует идентификатор проверки."
        case .invalidVerificationID:
            return "Неверный идентификатор проверки."
        case .missingAppCredential:
            return "Отсутствуют учетные данные приложения."
        case .invalidAppCredential:
            return "Неверные учетные данные приложения."
        case .sessionExpired:
            return "Сеанс истек."
        case .quotaExceeded:
            return "Превышен лимит."
        case .missingAppToken:
            return "Отсутствует токен приложения."
        case .notificationNotForwarded:
            return "Уведомление не перенаправлено."
        case .appNotVerified:
            return "Приложение не подтверждено."
        case .captchaCheckFailed:
            return "Проверка капчи не пройдена."
        case .webContextAlreadyPresented:
            return "Контекст веб-приложения уже представлен."
        case .webContextCancelled:
            return "Контекст веб-приложения отменен."
        case .appVerificationUserInteractionFailure:
            return "Ошибка взаимодействия пользователя с подтверждением приложения."
        case .invalidClientID:
            return "Неверный идентификатор клиента."
        case .webNetworkRequestFailed:
            return "Ошибка сетевого запроса веб-приложения."
        case .webInternalError:
            return "Внутренняя ошибка веб-приложения."
        case .webSignInUserInteractionFailure:
            return "Ошибка взаимодействия пользователя с входом в веб-приложение."
        case .localPlayerNotAuthenticated:
            return "Местный игрок не аутентифицирован."
        case .nullUser:
            return "Пустой пользователь."
        case .dynamicLinkNotActivated:
            return "Динамическая ссылка не активирована."
        case .invalidProviderID:
            return "Неверный идентификатор поставщика."
        case .tenantIDMismatch:
            return "Несоответствие идентификатора арендатора."
        case .unsupportedTenantOperation:
            return "Неподдерживаемая операция арендатора."
        case .invalidDynamicLinkDomain:
            return "Неверный домен динамической ссылки."
        case .rejectedCredential:
            return "Отклоненные учетные данные."
        case .gameKitNotLinked:
            return "GameKit не связан."
        case .secondFactorRequired:
            return "Требуется второй фактор."
        case .invalidMultiFactorSession:
            return "Неверная сессия многофакторной аутентификации."
        case .multiFactorInfoNotFound:
            return "Сведения о многофакторной аутентификации не найдены."
        case .adminRestrictedOperation:
            return "Операция ограничена администратором."
        case .unverifiedEmail:
            return "Непроверенная электронная почта."
        case .secondFactorAlreadyEnrolled:
            return "Второй фактор уже зарегистрирован."
        case .maximumSecondFactorCountExceeded:
            return "Превышено максимальное количество вторичных факторов"
        case .unsupportedFirstFactor:
            return "Неподдерживаемый первичный фактор."
        case .emailChangeNeedsVerification:
            return "Требуется подтверждение изменения адреса электронной почты."
        case .missingClientIdentifier:
            return "Отсутствует идентификатор клиента"
        case .missingOrInvalidNonce:
            return "Отсутствует или неверный nonce."
        case .blockingCloudFunctionError:
            return "Ошибка блокирующей"
        case .missingMultiFactorSession:
            return "Отсутствует сессия многофакторной аутентификации."
        case .missingMultiFactorInfo:
            return "Отсутствуют сведения о многофакторной аутентификации."
        case .invalidPassword:
            return "Пароль должен содержать минимум 8 символов, хотя бы одну букву и одну цифру."
        case .passwordDoNotMatch:
            return "Пароли не совпадают."
        }
    }
}

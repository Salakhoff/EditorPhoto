//
//  DrawingViewModel.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 15.05.2024.
//

import SwiftUI
import PencilKit
import CoreImage
import CoreImage.CIFilterBuiltins

class DrawingViewModel: ObservableObject {
    
    // MARK: Published
    
    @Published var canvas = PKCanvasView()
    @Published var toolPicker = PKToolPicker()
    @Published var imageData: Data = Data(count: 0)
    @Published var textBoxes: [TextBox] = []
    @Published var rect: CGRect = .zero
    @Published var messageSaveImage: String = ""
    @Published var messageExitProfile: String = ""
    @Published var currentIndex: Int = 0
    @Published var isShowImagePicker = false
    @Published var isShowSuccessSaveAlert = false
    @Published var isShowExitProfileAlret = false
    @Published var isShowingAlert = false
    @Published var isAddNewBox = false
    
    /// Эта функция вызывается, когда пользователь полностью закончил работу с редактированием изображения и хочет вернуться к исходному состоянию.
    func cancelImageEditing() {
        // Устанавливаем `imageData` в пустые данные. Это эффективно удаляет текущее изображение.
        imageData = Data(count: 0)
        
        // Создаем новый экземпляр `PKCanvasView`. Это сбрасывает текущее состояние холста.
        canvas = PKCanvasView()
        
        // Удаляем все текстовые блоки. Это удаляет все добавленные пользователем текстовые блоки.
        textBoxes.removeAll()
    }
    
    /// Этот метод вызывается, когда пользователь закончил редактирование текстового блока и хочет отменить все изменения.
    func cancelTextView() {
        // Устанавливаем `toolPicker` видимым и делаем `canvas` первым респондентом.
        // Это позволяет пользователю продолжить рисование на холсте после отмены редактирования текстового блока.
        toolPicker.setVisible(true, forFirstResponder: canvas)
        canvas.becomeFirstResponder()
        
        // С анимацией устанавливаем `addNewBox` в `false`.
        // Это скрывает текстовое поле для редактирования.
        withAnimation {
            isAddNewBox = false
        }
        
        // Если текущий текстовый блок не был добавлен (то есть он был только что создан, но не сохранен),
        // удаляем его из массива `textBoxes`
        //FIXME: Проблема с кнопкой.
        if !textBoxes[currentIndex].isAdded {
            textBoxes.removeLast()
        }
    }
    
    /// Метод `saveImage` используется для сохранения текущего состояния холста и текстовых блоков в изображение и сохранения этого изображения в фотоальбом устройства.
    func saveImage() {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        // Начинаем контекст изображения с определенными размерами и настройками.
        canvas.drawHierarchy(
            in: CGRect(
                origin: .zero,
                size: rect.size
            ), afterScreenUpdates: true
        )
        
        // Создаем SwiftUI представление, которое содержит все текстовые блоки.
        let swiftUIView = ZStack {
            ForEach(textBoxes) { [self] box in
                Text(
                    textBoxes[
                        currentIndex
                    ].id ==  box.id && isAddNewBox ? "" : box.text)
                .font(.system(size: 30))
                .fontWeight(box.isBold ? .bold : .none)
                .foregroundStyle(box.textColor)
                .offset(box.offset)
            }
        }
        
        // Создаем контроллер представления, который будет отображать наше SwiftUI представление.
        let controller = UIHostingController(rootView: swiftUIView).view!
        controller.frame = rect
        
        // Устанавливаем фон контроллера представления и холста в прозрачный.
        controller.backgroundColor = .clear
        canvas.backgroundColor = .clear
        
        // Рисуем иерархию представлений контроллера представления в контекст изображения.
        controller.drawHierarchy(
            in: CGRect(
                origin: .zero,
                size: rect.size
            ), afterScreenUpdates: true
        )
        
        // Получаем сгенерированное изображение из контекста изображения.
        let generatedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // Завершаем контекст изображения.
        UIGraphicsEndImageContext()
        
        // Если мы успешно сгенерировали изображение, сохраняем его в фотоальбом устройства.
        if let image = generatedImage?.pngData() {
            UIImageWriteToSavedPhotosAlbum(
                UIImage(data: image)!,
                nil,
                nil,
                nil
            )
        }
        
        self.messageSaveImage = "imageSavedSuccessfully".localized
        self.isShowSuccessSaveAlert.toggle()
        self.isShowingAlert.toggle()
    }
    
    /// Этот метод вызывается, когда пользователь нажимает кнопку выхода из профиля
    func exitProfile() {
        self.messageExitProfile = "confirmProfileExit".localized
        self.isShowExitProfileAlret.toggle()
        self.isShowingAlert.toggle()
    }
}

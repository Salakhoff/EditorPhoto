//
//  ImagePicker.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 15.05.2024.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
   
    // MARK: Binding
    
    @Binding var isShowPicker: Bool
    @Binding var imageData: Data
    
    /// Создает и возвращает координатор для управления `ImagePicker`.
    /// Координатор используется для обработки событий и управления логикой выбора изображений.
    /// - Returns: Координатор `Coordinator`, связанный с данным `ImagePicker`
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent: self)
    }
    
    /// Создает и возвращает экземпляр `PHPickerViewController`, который предоставляет пользователю интерфейс выбора изображений.
    /// - Parameter context: Контекст представления, содержащий информацию о среде выполнения.
    /// - Returns: Экземпляр `PHPickerViewController` с базовой конфигурацией и делегатом, связанным с координатором контекста.
    func makeUIViewController(context: Context) -> PHPickerViewController {
        let picker = PHPickerViewController(configuration: PHPickerConfiguration())
        picker.delegate = context.coordinator
        
        return picker
    }
    
    /// Обновляет представление `PHPickerViewController`.
    /// - Parameters:
    ///   - uiViewController: Экземпляр `PHPickerViewController`, который нужно обновить.
    ///   - context: Контекст представления, содержащий информацию о среде выполнения.
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
    
    class Coordinator : NSObject, PHPickerViewControllerDelegate {
        
        var parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        /// Обрабатывает событие завершения выбора изображений в `PHPickerViewController`.
        /// Если выбранное изображение может быть загружено, сохраняет его данные и скрывает выборщик.
        /// - Parameters:
        ///   - picker: `PHPickerViewController`, из которого были выбраны результаты.
        ///   - results: Массив `PHPickerResult`, содержащий выбранные элементы.
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard let firstResult = results.first,
                  firstResult.itemProvider.canLoadObject(ofClass: UIImage.self) else {
                self.parent.isShowPicker.toggle()
                return
            }
            
            firstResult.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                guard let self else { return }
                
                DispatchQueue.main.async {
                    if let image = image as? UIImage {
                        self.parent.imageData = image.pngData()!
                    }
                    self.parent.isShowPicker.toggle()
                }
            }
        }
    }
}

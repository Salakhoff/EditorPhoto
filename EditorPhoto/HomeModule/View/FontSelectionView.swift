//
//  FontSelectionView.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 16.05.2024.
//

import SwiftUI

/// Отображает элементы управления для выбора цвета и жирности текста в приложении.
struct FontSelectionView: View {
    
    @ObservedObject var viewModel: DrawingViewModel
    var body: some View {
        HStack(spacing: 15) {
            ColorPicker(
                "",
                selection: $viewModel.textBoxes[
                    viewModel.currentIndex
                ].textColor)
            .labelsHidden()
            
            Button {
                viewModel.textBoxes[
                    viewModel.currentIndex
                ].isBold.toggle()
            } label: {
                Text(
                    viewModel.textBoxes[
                        viewModel.currentIndex
                    ].isBold ? "normal".localized : "bold".localized
                )
                .fontWeight(.bold)
                .foregroundStyle(.white)
            }
        }
    }
}

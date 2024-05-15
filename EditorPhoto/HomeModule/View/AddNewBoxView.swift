//
//  AddNewBoxView.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 15.05.2024.
//

import SwiftUI

/// Представляет собой интерфейс для добавления и редактирования новых текстовых блоков в приложении.
struct AddNewBoxView: View {
    @ObservedObject var viewModel: DrawingViewModel
    
    var body: some View {
        Color.black.opacity(0.75)
            .ignoresSafeArea()
        TextField(
            "writeText".localized,
            text: $viewModel.textBoxes[viewModel.currentIndex].text
        )
        .font(
            .system(
                size: 20,
                weight: viewModel.textBoxes[
                    viewModel.currentIndex
                ].isBold ? .bold : .regular
            )
        )
        .preferredColorScheme(.dark)
        .foregroundColor(viewModel.textBoxes[viewModel.currentIndex].textColor)
        .padding()
        
        AdditionalButtons(viewModel: viewModel)
        .overlay {
            FontSelectionView(viewModel: viewModel)
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

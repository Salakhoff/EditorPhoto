//
//  AdditionalButton.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 16.05.2024.
//

import SwiftUI

/// Предоставляет методы для добавления и редактирования текстовых блоков.
struct AdditionalButtons: View {
    
    @ObservedObject var viewModel: DrawingViewModel
    
    var body: some View {
        HStack {
            Button {
                viewModel.textBoxes[
                    viewModel.currentIndex
                ].isAdded = true
                
                viewModel.toolPicker.setVisible(
                    true,
                    forFirstResponder: viewModel.canvas
                )
                viewModel.canvas.becomeFirstResponder()
                withAnimation {
                    viewModel.addNewBox = false
                }
            } label: {
                Text("add".localized)
                    .fontWeight(.heavy)
                    .foregroundStyle(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
            
            Spacer()
            
            Button {
                viewModel.cancelTextView()
            } label: {
                Text("cancel".localized)
                    .fontWeight(.heavy)
                    .foregroundStyle(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
        }
    }
}



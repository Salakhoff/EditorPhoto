//
//  AddNewBoxView.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 15.05.2024.
//

import SwiftUI

/// Представляет собой интерфейс для добавления и редактирования новых текстовых блоков в приложении.
struct AddNewBoxView: View {
    
    // MARK: Properties
    
    @EnvironmentObject var viewModel: DrawingViewModel
    
    // MARK: Body
    
    var body: some View {
        backgroundColorView
        writeTextField
        
        HStack {
            addTextButton
            Spacer()
            cancelTextButton
        }
        .overlay {
            HStack(spacing: 15) {
                colorPicker
                fontSizeButton
            }
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
    
    // MARK: Some Views
    
    private var backgroundColorView: some View {
        Color.black.opacity(0.75)
            .ignoresSafeArea()
    }
    
    private var writeTextField: some View {
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
    }
    
    private var addTextButton: some View {
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
                viewModel.isAddNewBox = false
            }
        } label: {
            Text("add".localized)
                .fontWeight(.heavy)
                .foregroundStyle(.black)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
        }
    }
    
    private var cancelTextButton: some View {
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
    
    private var colorPicker: some View {
        ColorPicker(
            "",
            selection: $viewModel.textBoxes[
                viewModel.currentIndex
            ].textColor)
        .labelsHidden()
    }
    
    private var fontSizeButton: some View {
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

//
//  DrawingScreen.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 15.05.2024.
//

import Foundation
import SwiftUI
import PencilKit

/// Представляет собой экран рисования
struct DrawingScreen: View {
    
    // MARK: Properties
    
    @EnvironmentObject var viewModel: DrawingViewModel
    
    // MARK: Body
    
    var body: some View {
        ZStack {
            GeometryReaderView()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                saveButton
            }
            ToolbarItem(placement: .topBarTrailing) {
                plusButton
            }
            ToolbarItem(placement: .topBarLeading) {
                cancelButton
            }
        }
    }
    
    // MARK: Some Views
    
    private var saveButton: some View {
        Button {
            viewModel.saveImage()
        } label: {
            Text("save".localized)
        }
    }
    
    private var plusButton: some View {
        Button {
            viewModel.textBoxes.append(TextBox())
            viewModel.currentIndex = viewModel.textBoxes.count - 1
            withAnimation {
                viewModel.isAddNewBox.toggle()
            }
            viewModel.toolPicker.setVisible(
                false,
                forFirstResponder: viewModel.canvas
            )
            viewModel.canvas.resignFirstResponder()
        } label: {
            Image(systemName: "plus")
        }
    }
    
    private var cancelButton: some View {
        Button {
            viewModel.cancelImageEditing()
        } label: {
            Image(systemName: "xmark")
        }
    }
}

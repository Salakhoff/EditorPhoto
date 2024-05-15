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
    @EnvironmentObject var viewModel: DrawingViewModel
    
    var body: some View {
        ZStack {
            GeometryReaderView(viewModel: viewModel)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.saveImage()
                } label: {
                    Text("save".localized)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.textBoxes.append(TextBox())
                    viewModel.currentIndex = viewModel.textBoxes.count - 1
                    withAnimation {
                        viewModel.addNewBox.toggle()
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
            ToolbarItem(
                placement: .topBarLeading) {
                    Button {
                        viewModel.cancelImageEditing()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
        }
    }
}

//
//  ButtonAddImage.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 16.05.2024.
//

import SwiftUI

/// Представляет собой главное меню в приложении.
struct MenuView: View {
    @ObservedObject var viewModel: DrawingViewModel
    
    var body: some View {
        Button(role: .destructive) {
            viewModel.showImagePicker = true
        } label: {
            Text("processPhoto".localized)
                .bold()
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                )
        }
        .toolbar {
            ToolbarItem(
                placement: .topBarTrailing) {
                    Button(role: .destructive) {
                        viewModel.exitProfile()
                    } label: {
                        Image(systemName: "arrow.forward.circle.fill")
                    }
                }
        }
    }
}

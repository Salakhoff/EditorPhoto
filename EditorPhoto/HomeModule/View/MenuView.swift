//
//  ButtonAddImage.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 16.05.2024.
//

import SwiftUI

/// Представляет собой главное меню в приложении.
struct MenuView: View {
    
    // MARK: Properties
    
    @EnvironmentObject var viewModel: DrawingViewModel
    
    // MARK: Body
    
    var body: some View {
        photoButton.toolbar {
            ToolbarItem(placement:.topBarTrailing) {
                exitProfileButton
            }
        }
    }
    
    // MARK: Some View
    
    private var photoButton: some View {
        Button(role: .destructive) {
            viewModel.isShowImagePicker = true
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
    }
    
    private var exitProfileButton: some View {
        Button(role: .destructive) {
            viewModel.exitProfile()
        } label: {
            Image(systemName: "arrow.forward.circle.fill")
        }
    }
}

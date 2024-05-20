//
//  HomeView.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 14.05.2024.
//

import SwiftUI

/// Стартовый экран
struct HomeView: View {
    
    // MARK: StateObject
    
    @StateObject var viewModel = DrawingViewModel()
    
    // MARK: Body
    
    var body: some View {
        ZStack {
            NavigationView {
                if UIImage(data: viewModel.imageData) != nil {
                    DrawingScreen()
                } else {
                    MenuView()
                        .padding()
                }
            }
            .navigationTitle("editor".localized)
            
            if viewModel.isAddNewBox {
                AddNewBoxView()
            }
        }
        .environmentObject(viewModel)
        .sheet(isPresented: $viewModel.isShowImagePicker) {
            ImagePicker(
                isShowPicker: $viewModel.isShowImagePicker,
                imageData: $viewModel.imageData
            )
            .ignoresSafeArea()
        }
        .alert(isPresented: $viewModel.isShowingAlert) {
            if viewModel.isShowExitProfileAlret {
                return Alert(title: Text(viewModel.messageExitProfile),
                             primaryButton: .default(Text("yes".localized),
                                                     action: { _ = AuthService.shared.signOut() }),
                             secondaryButton: .default(Text("no".localized))
                )
            } else if viewModel.isShowSuccessSaveAlert {
                return Alert(title: Text(viewModel.messageSaveImage),
                             dismissButton: .default(Text("ok".localized))
                )
            } else {
                return Alert(title: Text("Ошибка..."),
                             dismissButton: .default(Text("ok".localized))
                )
            }
        }
    }
}

#Preview {
    HomeView()
}

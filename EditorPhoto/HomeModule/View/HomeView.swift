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
                VStack() {
                    if UIImage(data: viewModel.imageData) != nil {
                        DrawingScreen()
                            .environmentObject(viewModel)
                    } else {
                        MenuView(viewModel: viewModel)
                            .padding()
                    }
                }
                .navigationTitle("editor".localized)
            }
            if viewModel.addNewBox {
                AddNewBoxView(viewModel: viewModel)
            }
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(
                isShowPicker: $viewModel.showImagePicker,
                imageData: $viewModel.imageData
            )
            .ignoresSafeArea()
        }
        .alert(isPresented: $viewModel.showingAlert) {
            if viewModel.showExitProfileAlret {
                return Alert(
                    title: Text(viewModel.messageExitProfile),
                    primaryButton: .default(Text("yes".localized),
                    action: { _ = AuthService.shared.signOut() }),
                    secondaryButton: .default(Text("no".localized))
                )
            } else if viewModel.showSuccessSaveAlert {
                return Alert(
                    title: Text(viewModel.messageSaveImage),
                    dismissButton: .default(Text("ok".localized))
                )
            } else {
                return Alert(
                    title: Text("Ошибка..."),
                    dismissButton: .default(Text("ok".localized))
                )
            }
        }
    }
}

#Preview {
    HomeView()
}

//
//  HomeView.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 14.05.2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = DrawingViewModel()
    
    var body: some View {
        
        ZStack {
            NavigationView {
                VStack{
                    if UIImage(data: viewModel.imageData) != nil {
                        
                        DrawingScreen()
                            .environmentObject(viewModel)
                            .toolbar {
                                ToolbarItem(
                                    placement: .topBarLeading) {
                                        Button {
                                            viewModel.cancelImageEditing()
                                        } label: {
                                            Image(systemName: "xmark")
                                        }
                                    }
                            }
                        
                    } else {
                        Button {
                            viewModel.showImagePicker.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .font(.title)
                                .foregroundColor(.black)
                                .frame(width: 50, height: 50)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(
                                    color: Color.black.opacity(0.4),
                                    radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/,
                                    x: 5,
                                    y: 5
                                )
                        }
                        
                    }
                }
                .navigationTitle("Редактор")
            }
            
            if viewModel.addNewBox {
                Color.black.opacity(0.75)
                    .ignoresSafeArea()
                
                TextField(
                    "Напиши текст...",
                    text: $viewModel.textBoxes[viewModel.currentIndex].text
                )
                .font(
                    .system(
                        size: 35,
                        weight: viewModel.textBoxes[
                            viewModel.currentIndex
                        ].isBold ? .bold : .regular
                    )
                )
                .preferredColorScheme(.dark)
                .foregroundColor(viewModel.textBoxes[viewModel.currentIndex].textColor)
                .padding()
                
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
                        Text("Add")
                            .fontWeight(.heavy)
                            .foregroundStyle(.white)
                            .padding()
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.cancelTextView()
                    } label: {
                        Text("Cancel")
                            .fontWeight(.heavy)
                            .foregroundStyle(.white)
                            .padding()
                    }
                }
                .overlay {
                    HStack(spacing: 15) {
                        ColorPicker(
                            "",
                            selection: $viewModel.textBoxes[
                                viewModel.currentIndex
                            ].textColor)
                        .labelsHidden()
                    }
                    
                    Button {
                        viewModel.textBoxes[
                            viewModel.currentIndex
                        ].isBold.toggle()
                    } label: {
                        Text(
                            viewModel.textBoxes[
                                viewModel.currentIndex
                            ].isBold ? "Normal" : "Bold"
                        )
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    }

                }
                
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(
                showPicker: $viewModel.showImagePicker,
                imageData: $viewModel.imageData
            )
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text(viewModel.message),
                primaryButton: .destructive(Text("OK")),
                secondaryButton: .cancel()
            )
        }
        
        Button(role: .destructive) {
            _ = AuthService.shared.signOut()
        } label: {
            Text("Выйти")
        }
    }
}

#Preview {
    HomeView()
}

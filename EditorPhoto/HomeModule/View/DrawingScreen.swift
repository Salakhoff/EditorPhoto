//
//  DrawingScreen.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 15.05.2024.
//

import Foundation
import SwiftUI
import PencilKit

struct DrawingScreen: View {
    @EnvironmentObject var viewModel: DrawingViewModel
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                
                let size = proxy.frame(in: .local)
                
                ZStack {
                    CanvasView(
                        canvas: $viewModel.canvas,
                        imageData: $viewModel.imageData,
                        toolPicker: $viewModel.toolPicker,
                        rect: size.size
                    )
                    
                    ForEach(viewModel.textBoxes) { box in
                        Text(
                            viewModel.textBoxes[
                                viewModel.currentIndex
                            ].id ==  box.id && viewModel.addNewBox ? "" : box.text)
                        .font(.system(size: 30))
                        .fontWeight(box.isBold ? .bold : .none)
                        .foregroundStyle(box.textColor)
                        .offset(box.offset)
                        .gesture(
                            DragGesture().onChanged({ value in
                                let current = value.translation
                                let lastOffset = box.lastOffset
                                let newTranslation = CGSize(
                                    width: lastOffset.width + current.width,
                                    height: lastOffset.height + current.height)
                                
                                viewModel.textBoxes[getIndex(textBox: box)].offset = newTranslation
                            })
                            .onEnded({ value in
                                viewModel.textBoxes[
                                    getIndex(textBox: box)
                                ].lastOffset = value.translation
                            })
                            
                            .onLongPressGesture {
                                viewModel.toolPicker.setVisible(
                                    false,
                                    forFirstResponder: viewModel.canvas
                                )
                                viewModel.canvas.resignFirstResponder()
                                viewModel.currentIndex = getIndex(textBox: box)
                                withAnimation {
                                    viewModel.addNewBox = true
                                    
                                }
                            }
                        )
                    }
                }
                .onAppear {
                        if viewModel.rect == .zero {
                            viewModel.rect = size
                        }
                    }
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.saveImage()
                } label: {
                    Text("Сохранить")
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
        }
    }
    
    func getIndex(textBox: TextBox) -> Int {
        let index = viewModel.textBoxes.firstIndex { box in
            return textBox.id == box.id
        }
        
        return index ?? 0
    }
}

struct CanvasView: UIViewRepresentable {
    
    @Binding var canvas: PKCanvasView
    @Binding var imageData: Data
    @Binding var toolPicker: PKToolPicker
    
    var rect: CGSize
    
    func makeUIView(context: Context) -> PKCanvasView {
        
        canvas.isOpaque = false
        canvas.backgroundColor = .clear
        canvas.drawingPolicy = .anyInput
        
        if let image = UIImage(data: imageData) {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            
            let subView = canvas.subviews[0]
            subView.addSubview(imageView)
            subView.sendSubviewToBack(imageView)
            
            toolPicker.setVisible(true, forFirstResponder: canvas)
            toolPicker.addObserver(canvas)
            canvas.becomeFirstResponder()
        }
        
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
    }
    
}

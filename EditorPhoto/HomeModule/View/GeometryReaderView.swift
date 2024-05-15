//
//  GeometryReaderView.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 15.05.2024.
//

import SwiftUI

/// Отслеживает текущее состояние каждого текстового блока, включая его текст, шрифт, цвет и положение. Пользователи могут перемещать и редактировать каждый текстовый блок по своему усмотрению.
struct GeometryReaderView: View {
    @ObservedObject var viewModel: DrawingViewModel
    
    var body: some View {
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
                        
                        
                    )
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
                }
            }
            .onAppear {
                if viewModel.rect == .zero {
                    viewModel.rect = size
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

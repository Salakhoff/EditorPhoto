//
//  ContentView.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 13.05.2024.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFill()
                .overlay {
                    LinearGradient(
                        gradient: Gradient(
                            colors: [.white, .clear]
                        ),
                        startPoint: .bottom, endPoint: .top
                    )
                }
                .frame(height: 120)
            
            Spacer()
            
            VStack {
                FirebaseTextField(
                    placeholder: "Эл.почта",
                    text: $viewModel.email
                )
                
                FirebaseSecureTextField(
                    placeholder: "Пароль",
                    text: $viewModel.password,
                    showPassword: $viewModel.isShowPassword
                )
                
                Button("Забыли пароль?") {
                    
                }
                .foregroundColor(.black)
                .bold()
                .padding(.vertical)
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Button("Войти") {
                    
                }
                .bold()
                .foregroundColor(.white)
                .padding()
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                )
            }.padding()
            
            Spacer()
            
            VStack {
                Text("У вас нет аккаунта?")
                Button("Зарегистрироваться") {
                }
                .bold()
                .foregroundColor(.black)
                .padding()
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.ultraThinMaterial)
                        .stroke(.primary, style: StrokeStyle(lineWidth: 1)
                               )
                )
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, 60)
    }
}

#Preview {
    LoginView()
}

//
//  HomeView.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 14.05.2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Button(role: .destructive) {
            do {
                try AuthService.shared.signOut()
            } catch {
                print(error.localizedDescription)
            }
        } label: {
            Text("Выйти")
        }
    }
}

#Preview {
    HomeView()
}

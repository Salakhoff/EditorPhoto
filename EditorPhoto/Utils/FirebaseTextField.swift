//
//  EntryField.swift
//  EditorPhoto
//
//  Created by Ильфат Салахов on 13.05.2024.
//

import SwiftUI

struct FirebaseTextField: View {
    
    // MARK: Properties
    
    var placeholder: String
    @Binding var text: String
    
    // MARK: Body
    
    var body: some View {
        TextField(placeholder, text: $text)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .padding()
            .foregroundColor(.primary)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
                    .stroke(.primary, style: StrokeStyle(lineWidth: 1))
            )
    }
}

#Preview {
    LoginView()
}

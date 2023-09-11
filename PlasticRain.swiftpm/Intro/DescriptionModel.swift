//
//  File.swift
//  
//
//  Created by 한지석 on 2023/04/11.
//

import SwiftUI

struct DescriptionRectangle: View, Identifiable {
    let id = UUID()
    let text: String
    
    var body: some View {
        Rectangle()
            .frame(width: 750, height: 150)
            .cornerRadius(30)
            .foregroundColor(.white)
            .padding(.leading, 30)
            .overlay {
                Text(text)
                    .font(.system(size: 36))
            }
    }
}

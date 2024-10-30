//
//  VocabularyCard.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/29/24.
//

import SwiftUI

struct VocabularyCard: View {
    var text: String = ""
    var filled: Bool = true
    
    var backgroundColor: Color?
    
    var body: some View {
        HStack {
            HStack(spacing: 9) {
                Image("Icon/Filled/star")
                    .renderingMode(.template)
                    .foregroundColor(filled ? .accent.primary : .content.secondary)
                    .frame(width: 24, height: 24)
                
                Text(text)
                    .typography(.label, color: .content.primary)
            }
            
            Spacer()
            
            Text("3")
                .typography(.label, color: .accent.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 13)
        .padding(.vertical, 16)
        .background(backgroundColor == nil ? (filled ? Color.accent.transparent : Color.fill.secondary) : backgroundColor)
        .cornerRadius(5)
    }
}

#Preview {
    VocabularyCard()
}

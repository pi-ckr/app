//
//  StudyCard.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/30/24.
//

import SwiftUI

struct StudyCard: View {
    var title: String
    var description: String
    var icon: String
    
    var backgroundColor: Color
    
    var body: some View {
        VStack(spacing: 6) {
            VStack(alignment: .leading) {
                Text(title)
                    .typography(.title, color: .content.primary)
                Text(description)
                    .multilineTextAlignment(.leading)
                    .typography(.body, color: .content.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            HStack {
                Image(icon)
                    .renderingMode(.template)
                    .foregroundStyle(Color.fill.invert)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 196)
        .padding(20)
        .background(backgroundColor)
    }
}

#Preview {
    HStack {
        StudyCard(title: "단어 외우기", description: "기본 어휘를\n암기하며 학습", icon: "ABC", backgroundColor: .red)
        StudyCard(title: "단어 외우기", description: "기본 어휘를\n암기하며 학습", icon: "ABC", backgroundColor: .blue)
    }
}

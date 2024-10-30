//
//  WordCard.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/29/24.
//

import SwiftUI

struct WordCard: View {
    var word: Word
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(word.english)
                .typography(.title, color: .content.primary)
            
            Text(word.korean)
                .typography(.body, color: .content.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 13)
        .padding(.vertical, 8)
        .cornerRadius(4)
        .background(Color.background.tertiary)
    }
}

#Preview {
    WordCard(word: Word(english: "practice", korean: "연습"))
}

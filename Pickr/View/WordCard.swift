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
            Text(word.word)
                .typography(.title, color: .content.primary)
            
            Text(word.meanings[0])
                .typography(.body, color: .content.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 13)
        .padding(.vertical, 8)
        .background(Color.background.tertiary)
        .cornerRadius(4)
    }
}

#Preview {
    WordCard(word: Word(id: 0, word: "practice", meanings: ["설계하다"], sampleSentence: ""))
}

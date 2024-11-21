//
//  VocabularyCard.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/29/24.
//

import SwiftUI

struct VocabularyCard: View {
    var text: String = ""
    var words: [Word] = []
    var filled: Bool = true
    
    var backgroundColor: Color?
    
    @EnvironmentObject var viewModel: WordViewModel
    
    var body: some View {
        HStack {
            HStack(spacing: 9) {
                Button(action: {
                    Task {
                        let response = try await WordService.changeFavoriteVocabulary(text, favorite: !filled)
                        
                        viewModel.fetchVocabularyList()
                        
                        print(response)
                    }
                }) {
                    Icon(name: "Icon/Filled/star", color: filled ? .accent.primary : .content.secondary)
                }
                
                Text(text)
                    .typography(.label, color: .content.primary)
            }
            
            Spacer()
            
            Text("\(words.count)")
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
        .environmentObject(WordViewModel())
}

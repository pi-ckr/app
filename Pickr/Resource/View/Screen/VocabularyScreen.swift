//
//  HomeScreen.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/27/24.
//

import SwiftUI

struct VocabularyScreen: View {
    let words = [
        Word(english: "practice", korean: "연습하다"),
        Word(english: "design", korean: "설계하다"),
        Word(english: "goal", korean: "목표"),
        Word(english: "galaxy", korean: "은하수"),
        Word(english: "practice", korean: "연습하다"),
        Word(english: "practice", korean: "연습하다"),
    ]
    
    var body: some View {
        ScreenTemplate(titleBar: {
            TitleBar(title: "단어장", icon: {
                Image("Icon/plus")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.content.primary)
                    .frame(width: 24, height: 24)
            })
        }) {
            VStack(spacing: 27) {
                Card(title: "즐겨찾는 단어장", number: 13) {
                    VStack(spacing: 7) {
                        VocabularyCard(text: "업무 관련 단어 모음")
                        VocabularyCard(text: "요리 관련 단어 모음")
                        VocabularyCard(text: "ㅇㄹ")
                    }
                }
                .padding(.top, 11)
                
                VStack(spacing: 0) {
                    Card(title: "현재 내 단어 리스트", number: 3) {
                        
                        LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2)) {
                            ForEach(words) { word in
                                WordCard(word: word)
                            }
                        }
                    }
                    .padding(.vertical, 26)
                    .background(Color.background.secondary)
                    
                    Card(title: "단어장", number: 12) {
                        
                        VStack(spacing: 7) {
                            VocabularyCard(text: "업무 관련 단어 모음", filled: false)
                            VocabularyCard(text: "요리 관련 단어 모음", filled: false)
                            VocabularyCard(text: "ㅇㄹ", filled: false)
                        }
                    }
                    .padding(.top, 26)
                    .padding(.bottom, 116)
                    .background(Color.background.tertiary)
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    VocabularyScreen()
        .environmentObject(BottomBar.ViewModel())
}

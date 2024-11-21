//
//  StudyBottomSheet.swift
//  Pickr
//
//  Created by  jwkwon0817 on 11/12/24.

import SwiftUI


struct StudyBottomSheet: View {
    @EnvironmentObject var bottomBarViewModel: BottomBar.ViewModel
    @Binding var showSheet: Bool
    
    @Binding var selectedVocabulary: Vocabulary?
    
    @State private var scrollId = UUID()
    
    @EnvironmentObject var viewModel: WordViewModel
    
    var body: some View {
        VStack(spacing: 29) {
            Text("학습할 단어장 선택하기")
                .typography(.titleEmphasized, color: .content.primary)
                .padding(.top, 7)
            
            Group {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 10) {
                        Text("현재 선택된 단어 목록")
                            .typography(.headlineEmphasized, color: .content.primary)
                        
                        Text(selectedVocabulary != nil ? "\(selectedVocabulary!.words.count)개" : "")
                            .typography(.label, color: .content.primary)
                    }
                    
                    Text(selectedVocabulary != nil ? "\(selectedVocabulary!.words[0].word), \(selectedVocabulary!.words[1].word), \(selectedVocabulary!.words[2].word)..." :
                       "선택되지 않음.")
                       .typography(.headlineEmphasized, color: .content.primary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 15)
                .padding(.vertical, 18)
                .background(Color.fill.secondary)
                .cornerRadius(4)
            }
            .padding(.horizontal, 20)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 29) {
                    Card(title: "즐겨찾는 단어장", number: 3) {
                        VStack(spacing: 7) {
                            VocabularyCard(text: "업무 관련 단어 모음")
                            VocabularyCard(text: "요리 관련 단어 모음")
                            VocabularyCard(text: "ㅇㄹ")
                        }
                    }
                    
                    Card(title: "단어장", number: viewModel.vocabularyList.filter { $0.words.count >= 5 }.count) {
                        VStack(spacing: 7) {
                            ForEach(viewModel.vocabularyList.filter { $0.words.count >= 5 }) { vocabulary in
                                Button(action: {
                                    withAnimation {
                                        if vocabulary.words.count >= 5 {
                                            selectedVocabulary = vocabulary
                                        }
                                    }
                                }) {
                                    VocabularyCard(text: vocabulary.name, words: vocabulary.words, filled: false, backgroundColor: .background.tertiary)
                                }
                            }
                             
                        }
                    }
                }
                .padding(.bottom, 32)
            }
            .id(scrollId)
        }
        .frame(height: UIScreen.main.bounds.height * 0.8, alignment: .top)
        .presentationDragIndicator(.hidden)
        .onChange(of: bottomBarViewModel.selectedTab) { _, _ in
            scrollId = UUID()
            showSheet = false
        }
    }
}

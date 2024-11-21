//
//  VocabularyAddScreen.swift
//  Pickr
//
//  Created by  jwkwon0817 on 11/11/24.
//
import SwiftUI

struct VocabularyAddScreen: View {
    @Binding var isPresented: Bool
    @State var showSheet: Bool = false
    
    @State var vocabularyName: String = ""
    
    @State var wordList: [Word] = []
    
    @EnvironmentObject var viewModel: WordViewModel
    
    var body: some View {
        ZStack {
            ScreenTemplate(scroll: false, titleBar: {
                TitleBar(title: "단어장 추가하기", leftIcon: {
                    Icon(name: "Icon/arrow_back", color: Color.content.primary)
                }, leftAction: {
                    isPresented = false
                })
            }) {
                VStack(spacing: 0) {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 13) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("단어장 이름")
                                    .typography(.labelEmphasized, color: .content.primary)
                                
                                HStack {
                                    TextField(text: $vocabularyName) {
                                        Text("단어장 이름을 지어주세요")
                                            .typography(.label, color: .content.secondary)
                                    }
                                    .typography(.label, color: .content.primary)
                                    .padding(.vertical, 12)
                                    .border(width: 1.5, edges: [.bottom], color: .border.primary)
                                    .autocapitalization(.none)
                                }
                            }
                            .padding(.vertical, 14)
                            
                            VStack(alignment: .leading, spacing: 18) {
                                HStack(spacing: 10) {
                                    Text("단어장 단어 목록")
                                        .typography(.labelEmphasized, color: .content.primary)
                                    
                                    Text("\(wordList.count)")
                                        .typography(.label, color: .accent.primary)
                                }
                                
                                VStack(spacing: 8) {
                                    HStack(spacing: 4) {
                                        Button(action: {
                                            showSheet.toggle()
                                        }) {
                                            Text("새 단어 추가하기")
                                                .typography(.labelEmphasized, color: .accent.primary)
                                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding(.horizontal, 13)
                                        .padding(.vertical, 12)
                                        .background(Color.accent.transparent)
                                        .cornerRadius(4)
                                        
                                        Button(action: {}) {
                                            Text("선택된 단어 가져오기")
                                                .typography(.labelEmphasized, color: .white)
                                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding(.horizontal, 13)
                                        .padding(.vertical, 12)
                                        .background(Color.accent.primary)
                                        .cornerRadius(4)
                                    }
                                    .frame(maxWidth: .infinity)
                                    
                                    LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 4), count: 2), spacing: 4) {
                                        ForEach(wordList) { word in
                                            HStack {
                                                VStack(alignment: .leading, spacing: 0) {
                                                    Text(word.word)
                                                        .typography(.title, color: .content.primary)
                                                    Text(word.meanings[0])
                                                        .typography(.body, color: .content.secondary)
                                                }
                                                Spacer()
                                                Button(action: {
                                                    withAnimation(.smooth(duration: 0.2)) {
                                                        wordList.removeAll { item in
                                                            item.id == word.id
                                                        } 
                                                    }
                                                }) {
                                                    Icon(name: "Icon/close", color: Color.content.secondary)
                                                }
                                            }
                                            .padding(.horizontal, 13)
                                            .padding(.vertical, 8)
                                            .frame(maxWidth: .infinity)
                                            .background(Color.background.secondary)
                                            .cornerRadius(4)
                                        }
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    Button(action: {
                        if vocabularyName != "" && wordList.count > 0 {
                            Task {
                                do {
                                    let response = try await WordService.createVocabulary(vocabularyName, words: wordList.map { $0.word })
                                    viewModel.fetchVocabularyList()  // createVocabulary 성공 후 실행
                                    isPresented = false
                                } catch {
                                    print("Error creating vocabulary: \(error)")
                                    // 에러 처리
                                }
                            }
                        }
                    }) {
                        Text("단어장 추가하기")
                            .typography(.title, color: .white)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(Color.accent.primary)
                    .ignoresSafeArea(.all, edges: [.bottom])
                }
            }
            .bottomSheet(isShowing: $showSheet) {
                VocabularyAddBottomSheet(showSheet: $showSheet, wordList: $wordList)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ContentView.ViewModel())
        .environmentObject(OnboardView.ViewModel(loginStepAction: {}))
        .environmentObject(BottomBar.ViewModel())
        .environmentObject(WordViewModel())
        .environmentObject(AuthViewModel())
}

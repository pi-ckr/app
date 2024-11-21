//
//  HomeScreen.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/27/24.
//

import SwiftUI

struct VocabularyScreen: View {
    @EnvironmentObject var viewModel: WordViewModel
    
    @State var showDetail: Bool = false
    
    var body: some View {
        ScreenTemplate(titleBar: {
            TitleBar(title: "단어장", icon: {
                Icon(name: "Icon/plus", color: .content.primary)
            }, action: {
                showDetail = true
            })
        }) {
            VStack(spacing: 27) {
                Card(title: "즐겨찾는 단어장", number: viewModel.favoriteVocabularyList.count) {
                    VStack(spacing: 7) {
                        ForEach(viewModel.favoriteVocabularyList) { favoriteVocabulary in
                            VocabularyCard(text: favoriteVocabulary.name, words: favoriteVocabulary.words)
                        }
                    }
                }
                .padding(.top, 11)
                
                VStack(spacing: 0) {
                    Card(title: "현재 내 단어 리스트", number: viewModel.wordList.count) {
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2)) {
                                ForEach(viewModel.wordList) { word in
                                    WordCard(word: word)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 26)
                    .padding(.bottom, 160)
                    .background(Color.background.secondary)
                    
                    Card(title: "단어장", number: viewModel.vocabularyList.count) {
                        VStack(spacing: 7) {
                            ForEach(viewModel.vocabularyList) { vocabulary in
                                
                                VocabularyCard(text: vocabulary.name, words: vocabulary.words, filled: false)
                                    .contextMenu {
                                        Button(role: .destructive, action: {
                                            Task {
                                                let response = try await WordService.deleteVocabulary(vocabulary.name)
                                                viewModel.fetchVocabularyList()
                                                print(response)
                                            }
                                        }) {
                                            Label {
                                                Text("삭제하기")
                                                    .foregroundColor(.red)
                                            } icon: {
                                                Image(systemName: "trash")
                                                    .foregroundColor(.red)
                                            }
                                        }
                                    }
                                
                            }
                        }
                    }
                    .padding(.top, 26)
                    .padding(.bottom, 180)
                    .background(Color.background.tertiary)
                }
                .frame(maxWidth: .infinity) 
            }
            .frame(maxWidth: .infinity)
        }
        .detailNavigation(isPresented: $showDetail) {
            VocabularyAddScreen(isPresented: $showDetail)
        }
    }
}

struct VocabularyAddBottomSheet: View {
    @EnvironmentObject var bottomBarViewModel: BottomBar.ViewModel
    @EnvironmentObject var wordViewModel: WordViewModel
    @Binding var showSheet: Bool
    @Binding var wordList: [Word]
    @State var word: String = ""
    
    @State private var scrollId = UUID()
    @State private var safeAreaBottom: CGFloat = 0
    
    @State var searchResult: Word? = nil

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 12) {
                Text("새 단어 추가")
                    .typography(.titleEmphasized, color: .content.primary)
                    .padding(.top, 7)
                
                VStack(spacing: 4) {
                    HStack {
                        TextField(text: $word) {
                            Text("단어를 입력해 주세요")
                                .typography(.label, color: .content.secondary)
                        }
                        .typography(.label, color: .content.primary)
                        .padding(.vertical, 12)
                        .border(width: 1.5, edges: [.bottom], color: .border.primary)
                        .autocapitalization(.none)
                        
                        Button(action: {
                            Task {
                                searchResult = try await WordService.search(word)
                            } 
                        }) {
                            Icon(name: "Icon/search", color: .content.secondary)
                        }
                    }
                    .padding(.vertical, 14)
                    
                    if searchResult != nil {
                        WordAddCard(selected: true, word: searchResult!, action: {
                            word = ""
                            searchResult = nil
                        })
                    }

                }
                .padding(.horizontal, 20)
            }
            .frame(height: UIScreen.main.bounds.height * 0.8, alignment: .top)
            .presentationDragIndicator(.hidden)
            
            VStack(spacing: 0) {
                Button(action: {
                    if searchResult != nil {
                        wordList.append(searchResult!)
                    }
                    showSheet = false
                }) {
                    Text("완료")
                        .typography(.title, color: .white)
                        .frame(maxWidth: .infinity)
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(Color.accent.primary)
                
                // Safe area bottom inset
                Rectangle()
                    .fill(Color.accent.primary)
                    .frame(height: safeAreaBottom)
            }
            .ignoresSafeArea(.all, edges: [.bottom])
        }
        .onAppear {
            safeAreaBottom = getSafeAreaBottom()
        }
        .onChange(of: bottomBarViewModel.selectedTab) { _, _ in
            scrollId = UUID()
            showSheet = false
        }
    }
    
    // Helper function to get the safe area inset for bottom
    private func getSafeAreaBottom() -> CGFloat {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return 0 }
        return windowScene.windows.first?.safeAreaInsets.bottom ?? 0
    }
}

struct WordAddCard: View {
    var selected: Bool = false
    var word: Word
    var action: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(word.word)
                    .typography(.title, color: .content.primary)
                
                Text(word.meanings[0])
                    .typography(.body, color: .content.secondary)
            }
            
            Spacer()
            
            Button(action: {
                action()
            }) {
                Icon(name: selected ? "Icon/close" : "Icon/plus", color: selected ? .accent.primary : .content.primary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 13)
        .padding(.vertical, 12)
        .background(selected ? Color.accent.transparent : Color.background.tertiary)
        .cornerRadius(4)
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
 

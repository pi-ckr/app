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
    
    @State var showDetail: Bool = false
    
    var body: some View {
        ScreenTemplate(titleBar: {
            TitleBar(title: "단어장", icon: {
                Image("Icon/plus")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.content.primary)
                    .frame(width: 24, height: 24)
            }, action: {
//                    detailNavigationViewModel.showVocabularyAddScreen = true
                showDetail.toggle()
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
        .detailNavigation(isPresented: $showDetail) {
            VocabularyAddScreen(isPresented: $showDetail)
        }
    }
}

struct VocabularyAddScreen: View {
    @Binding var isPresented: Bool
    @State var showSheet: Bool = false
    
    @State var vocabularyName: String = ""
    
    var body: some View {
        ZStack {
            ScreenTemplate(scroll: false, titleBar: {
                TitleBar(title: "단어장 추가하기", leftIcon: {
                    Image("Icon/arrow_back")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.content.primary)
                        .frame(width: 24, height: 24)
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
                                
                                TextField(text: $vocabularyName) {
                                    Text("단어장 이름을 지어주세요")
                                        .typography(.label, color: .content.secondary)
                                }
                                .typography(.label, color: .content.primary)
                                .padding(.vertical, 12)
                                .border(width: 1.5, edges: [.bottom], color: .border.primary)
                                .autocapitalization(.none)
                            }
                            .padding(.vertical, 14)
                            
                            VStack(alignment: .leading, spacing: 18) {
                                HStack(spacing: 10) {
                                    Text("단어장 단어 목록")
                                        .typography(.labelEmphasized, color: .content.primary)
                                    
                                    Text("6")
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
                                        ForEach(1...6, id: \.self) { word in
                                            HStack {
                                                VStack(alignment: .leading, spacing: 0) {
                                                    Text("practice")
                                                        .typography(.title, color: .content.primary)
                                                    Text("연습하다")
                                                        .typography(.body, color: .content.secondary)
                                                }
                                                Spacer()
                                                Button(action: {}) {
                                                    Image("Icon/close")
                                                        .renderingMode(.template)
                                                        .resizable()
                                                        .frame(width: 24, height: 24)
                                                        .foregroundColor(.content.secondary)
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
                        isPresented = false
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
                VocabularyAddBottomSheet(showSheet: $showSheet)
            }
        }
    }
}

struct VocabularyAddBottomSheet: View {
    @EnvironmentObject var bottomBarViewModel: BottomBar.ViewModel
    @Binding var showSheet: Bool
    @State var word: String = ""
    
    @State private var scrollId = UUID()
    @State private var safeAreaBottom: CGFloat = 0 // Holds the bottom safe area inset

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 12) {
                Text("새 단어 추가")
                    .typography(.titleEmphasized, color: .content.primary)
                    .padding(.top, 7)
                
                VStack(spacing: 4) {
                    Group {
                        TextField(text: $word) {
                            Text("단어를 입력해 주세요")
                                .typography(.label, color: .content.secondary)
                        }
                        .typography(.label, color: .content.primary)
                        .padding(.vertical, 12)
                        .border(width: 1.5, edges: [.bottom], color: .border.primary)
                        .autocapitalization(.none)
                    }
                    .padding(.vertical, 14)
                    
                    VStack(spacing: 8) {
                        WordAddCard(selected: true, word: Word(english: "practice", korean: "연습하다"))
                        
                        ForEach(1...3, id: \.self) { _ in
                            WordAddCard(word: Word(english: "practice", korean: "연습하다"))
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .frame(height: UIScreen.main.bounds.height * 0.8, alignment: .top)
            .presentationDragIndicator(.hidden)
            
            VStack(spacing: 0) {
                Button(action: {
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
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(word.english)
                    .typography(.title, color: .content.primary)
                
                Text(word.korean)
                    .typography(.body, color: .content.secondary)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(selected ? "Icon/close" : "Icon/plus")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(selected ? .accent.primary : .content.secondary)
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
        .environmentObject(OnboardView.ViewModel(thirdStepAction: {}))
        .environmentObject(BottomBar.ViewModel())
}

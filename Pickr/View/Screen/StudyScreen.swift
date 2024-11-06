//
//  HomeScreen.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/27/24.
//

import SwiftUI

struct StudyScreen: View {
    @State var showSheet: Bool = false
    
    var body: some View {
        ScreenTemplate(titleBar: {
            TitleBar(title: "학습하기", icon: {
                Image("Icon/activity_zone")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.content.primary)
                    .frame(width: 24, height: 24)
            })
        }) {
            VStack(spacing: 30) {
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 0), count: 2), spacing: 0) {
                    StudyCard(title: "단어 외우기", description: "기본 어휘를\n암기하며 학습", icon: "ABC", backgroundColor: .background.primary)
                    StudyCard(title: "예문 맞추기", description: "문장 속에서\n알맞은 표현을 연습", icon: "Chat", backgroundColor: .background.secondary)
                    StudyCard(title: "자주 틀리는 단어", description: "취약한 단어를\n집중적으로 학습", icon: "Cross", backgroundColor: .background.tertiary)
                    StudyCard(title: "스토리 텔링", description: "이야기로\n자연스럽게 배우기", icon: "Book", backgroundColor: .background.quaternary)
                }
                
                VStack(spacing: 22) {
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("학습할 단어장")
                                .typography(.titleEmphasized, color: .content.primary)
                            Text("시험 공부 단어")
                                .typography(.label, color: .content.secondary)
                        }
                        
                        Spacer()
                        
                        Button(action: {
//                            bottomSheetViewModel.studySheet.toggle()
                            showSheet.toggle()
                        }) {
                            Text("변경")
                                .typography(.labelEmphasized, color: .content.primary)
                        }
                        .padding(.horizontal, 21)
                        .padding(.vertical, 8)
                        .background(Color.fill.primary)
                        .cornerRadius(2)
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 6) {
                            ForEach(["practice", "design", "goal"], id: \.self) { word in
                                Text(word)
                                    .typography(.headline, color: .content.primary)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(Color.fill.primary)
                            }
                        }
                        
                        HStack(spacing: 6) {
                            ForEach(["galaxy", "test", "pickr"], id: \.self) { word in
                                Text(word)
                                    .typography(.headline, color: .content.primary)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(Color.fill.primary)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 116)
            }
        }
        .bottomSheet(isShowing: $showSheet) {
            StudyBottomSheet(showSheet: $showSheet)
        }
    }
}

struct StudyBottomSheet: View {
    @EnvironmentObject var bottomBarViewModel: BottomBar.ViewModel
    @Binding var showSheet: Bool
    
    @State private var scrollId = UUID()
    
    var body: some View {
        VStack(spacing: 29) {
            Text("학습할 단어장 선택하기")
                .typography(.titleEmphasized, color: .content.primary)
                .padding(.top, 7)
            
            Group {
                VStack(spacing: 4) {
                    HStack(spacing: 10) {
                        Text("현재 선택된 단어 목록")
                            .typography(.headlineEmphasized, color: .content.primary)
                        
                        Text("3개")
                            .typography(.label, color: .content.primary)
                    }
                    
                    Text("apple, contribute, tree...")
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
                    
                    Card(title: "단어장") {
                        VStack(spacing: 7) {
                            VocabularyCard(text: "업무 관련 단어 모음", filled: false, backgroundColor: .background.tertiary)
                            VocabularyCard(text: "요리 관련 단어 모음", filled: false, backgroundColor: .background.tertiary)
                            VocabularyCard(text: "ㅇㄹ", filled: false, backgroundColor: .background.tertiary)
                            VocabularyCard(text: "ㅇㄹ", filled: false, backgroundColor: .background.tertiary)
                            
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

#Preview {
    ContentView()
        .environmentObject(ContentView.ViewModel())
        .environmentObject(OnboardView.ViewModel(thirdStepAction: {}))
        .environmentObject(BottomBar.ViewModel())
}

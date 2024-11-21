//
//  HomeScreen.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/27/24.
//

import SwiftUI

struct StudyScreen: View {
    @State var showSheet: Bool = false
    @State var quizStart: Int? = nil
    @State var wordQuizData: [Quiz]? = nil  // 퀴즈 데이터를 저장할 상태 추가
    @State var sentenceQuizData: [SentenceQuiz]? = nil  // 퀴즈 데이터를 저장할 상태 추가
    @State var wrongWordQuizData: [Quiz]? = nil
    @EnvironmentObject var viewModel: WordViewModel
    
    func loadQuiz() async {
        if let data = try? await WordService.getMemorizeWordQuiz(viewModel.selectedStudyVocabulary!.name) {
            // 가져온 데이터를 상태에 저장
            self.wordQuizData = data
        }
    }
    
    func loadWrongWord() async {
        if let history = viewModel.history {
            let mistakes = history.mistakeWords.map({ $0.word })
            
            if let data = try? await WordService.getWrongWordQuiz(incorrect: mistakes) {
                self.wrongWordQuizData = data
            }
        }
    }
    
    func loadSentence() async {
        if let data = try? await WordService.getExampleSentenceQuiz(viewModel.selectedStudyVocabulary!.name) {
            self.sentenceQuizData = data
        }
    }
    
    var body: some View {
        ScreenTemplate(titleBar: {
            TitleBar(title: "학습하기", icon: {
                Icon(name: "Icon/activity_zone", color: .content.primary)
            })
        }) {
            VStack(spacing: 0) {
                StudyHistoryCard()
                QuizCard(quizStart: $quizStart, selectedVocabulary: $viewModel.selectedStudyVocabulary)
                SelectedVocabularyCard(showSheet: $showSheet, selectedVocabulary: $viewModel.selectedStudyVocabulary)
            }
            .padding(.bottom, 96)
        }
        .bottomSheet(isShowing: $showSheet) {
            StudyBottomSheet(showSheet: $showSheet, selectedVocabulary: $viewModel.selectedStudyVocabulary)
        }
        .detailNavigation(isPresented: Binding(
            get: { quizStart != nil },
            set: { if !$0 {
                quizStart = nil
                wordQuizData = nil
                sentenceQuizData = nil
            }}
        )) {
            if let quizStart {
                switch quizStart {
                case 0:
                    if let wordQuizData {  // 데이터가 있으면 MemorizeWord 뷰 표시
                        MemorizeWord(selectedVocabulary: viewModel.selectedStudyVocabulary, quiz: wordQuizData)
                    } else {  // 데이터 로딩 중이면 로딩 표시
                        ProgressView()
                            .task {
                                await loadQuiz()
                            }
                    }
                    
                case 1:
                    if let sentenceQuizData {
                        StudySentence(selectedVocabulary: $viewModel.selectedStudyVocabulary, quiz: sentenceQuizData)
                    } else {
                        ProgressView()
                            .task {
                                await loadSentence()
                            }
                    }
                    
                case 2:
                    if let wrongWordQuizData {
                        if let history = viewModel.history {
                            MemorizeWrongWord(selectedVocabulary: history.mistakeWords, quiz: wrongWordQuizData)
                        } 
                    } else {
                        ProgressView()
                            .task {
                                await loadWrongWord()
                            }
                    }
                default:
                    Text("\(quizStart) 퀴즈")
                }
            }
        }
    }
}

struct StudyHistoryCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("오늘 학습 기록")
                .typography(.headlineEmphasized, color: Color.content.primary)
            
            HStack {
                ForEach(1...2, id: \.self) { _ in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("단어 외우기") 
                            .typography(.labelEmphasized, color: Color.content.primary)
                        Text("34분 전 · 정답율 80%")
                            .typography(.body, color: Color.content.secondary)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.background.secondary)
                    .cornerRadius(4)
                }
                
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
    }
    
}

struct QuizCard: View {
    @Binding var quizStart: Int?
    @Binding var selectedVocabulary: Vocabulary?
    
    @EnvironmentObject var viewModel: WordViewModel
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 0), count: 2), spacing: 0) {
            Button(action: {
                withAnimation {
                    if selectedVocabulary != nil {
                        quizStart = 0
                    }
                }
            }) {
                StudyCard(title: "단어 외우기", description: "기본 어휘를\n암기하며 학습", icon: "ABC", backgroundColor: .background.primary)
            }
            
            Button(action: {
                withAnimation {
                    if selectedVocabulary != nil {
                        quizStart = 1
                    }
                }
            }) {
                StudyCard(title: "예문 맞추기", description: "문장 속에서\n알맞은 표현을 연습", icon: "Chat", backgroundColor: .background.secondary)
            }
            
            Button(action: {
                withAnimation {
                    if let history = viewModel.history {
                        if history.mistakeWords.count > 0 {
                            quizStart = 2
                        }
                    }
                }
            }) {
                StudyCard(title: "자주 틀리는 단어", description: "취약한 단어를\n집중적으로 학습", icon: "Cross", backgroundColor: .background.tertiary)
            }
             
            Button(action: {
                withAnimation {
                    if selectedVocabulary != nil {
                        quizStart = 3
                    }
                }
            }) {
                StudyCard(title: "스토리 텔링", description: "이야기로\n자연스럽게 배우기", icon: "Book", backgroundColor: .background.quaternary)
            }
        }
    }
}

struct SelectedVocabularyCard: View {
    @Binding var showSheet: Bool
    @Binding var selectedVocabulary: Vocabulary?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("학습할 단어장")
                    .typography(.titleEmphasized, color: .content.primary)
                Text(selectedVocabulary != nil ? selectedVocabulary!.name : "선택된 단어장이 없습니다.")
                    .typography(.label, color:  .content.secondary)
            }
            
            Spacer()
            
            Button(action: {
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
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}


#Preview {
    ContentView()
        .environmentObject(ContentView.ViewModel())
        .environmentObject(OnboardView.ViewModel(loginStepAction: {}))
        .environmentObject(BottomBar.ViewModel())
        .environmentObject(AuthViewModel())
        .environmentObject(WordViewModel())
}

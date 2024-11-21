//
//  MemorizeWord.swift
//  Pickr
//
//  Created by  jwkwon0817 on 11/12/24.
//

import SwiftUI

struct MemorizeWrongWord: View {
    
    let selectedVocabulary: [Word]
    let quiz: [Quiz]
    @State var currentIndex: Int = 0
    
    @State var isFlipped: Bool = false
    
    @State var showDetail: Bool = false
  
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 19) {
                VStack(spacing: 43) {
                    VStack(spacing: 13) {
                        Text("\(currentIndex + 1)/\(selectedVocabulary.count)")
                            .typography(.labelEmphasized, color: .white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 6)
                            .background(Color.accent.primary)
                            .cornerRadius(40)
                        
                        Text(currentIndex == selectedVocabulary.count - 1 ? "이제 마지막 단어에요!" : "이 단어의 뜻을 기억해놓아요")
                            .typography(.headlineEmphasized, color: Color.accent.primary)
                    }
                    
                    VStack(spacing: 29) {
                        MemorizeWordCard(word: selectedVocabulary[currentIndex].word, meaning: selectedVocabulary[currentIndex].meanings[0], isFlipped: $isFlipped)
                        
                        Button(action: {
                            isFlipped.toggle()
                        }) {
                            HStack(spacing: 10) {
                                Icon(name: "Icon/360", color: .content.primary)
                                Text(isFlipped ? "앞면으로 돌려 단어 확인하기" : "뒷면으로 돌려 뜻 확인하기")
                                    .typography(.label, color: Color.content.primary)
                            }
                            .padding(.leading, 20)
                            .padding(.trailing, 24)
                            .padding(.vertical, 12)
                            .background(Color.background.secondary)
                            .cornerRadius(40)
                        }
                    }
                }
                
                HStack(spacing: 8) {
                    if currentIndex == 0 {
                        Rectangle()
                            .fill(.clear)
                            .frame(maxWidth: .infinity)
                            .frame(height: 54)
                    } else {
                        Button(action: {
                            withAnimation(.smooth(duration: 0.2)) {
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                }
                            }
                        }) {
                            Text("이전 단어")
                                .typography(.labelEmphasized, color: Color.content.primary)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Color.background.secondary)
                        .cornerRadius(4)
                    }
                    
                    if currentIndex == selectedVocabulary.count - 1 {
                        Button(action: {
                            showDetail = true
                        }) {
                            Text("학습 시작하기")
                                .typography(.labelEmphasized, color: .white)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Color.accent.primary)
                        .cornerRadius(4)
                    } else {
                        Button(action: {
                            withAnimation(.smooth(duration: 0.2)) {
                                if currentIndex < selectedVocabulary.count - 1 {
                                    currentIndex += 1
                                }
                            }
                        }) {
                            Text("다음 단어")
                                .typography(.labelEmphasized, color: .white)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Color.accent.primary)
                        .cornerRadius(4)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 24)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.primary)
        .detailNavigation(isPresented: $showDetail) {
            MemorizeWrongWordQuiz(quiz: quiz, selectedVocabulary: selectedVocabulary)
        }
    }
}

struct MemorizeWrongWordQuiz: View {
    let quiz: [Quiz]
    let selectedVocabulary: [Word]
    @State var currentIndex: Int = 0
    @State var isCorrect: Bool? = nil
    @State var answer: String? = nil
    @State var wrongList: [Word] = []
    @State var showDetail: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 44) {
                quizHeader
                quizWord
                optionsGrid
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.primary)
        .detailNavigation(isPresented: $showDetail) {
            MemorizeWrongWordResult(totalList: selectedVocabulary, wrongList: wrongList)
        } 
    }
    
    // MARK: - Quiz Header
    private var quizHeader: some View {
        VStack(spacing: 13) {
            HStack {
                Text("\(currentIndex + 1)/\(quiz.count)")
                    .typography(.labelEmphasized, color: .white)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 6)
            .background(Color.accent.primary)
            .cornerRadius(40)
            
            Text("이 단어의 뜻은 무엇일까요")
                .typography(.largeTitle, color: Color.content.primary)
        }
    }
    
    // MARK: - Quiz Word
    private var quizWord: some View {
        Text("\(quiz[currentIndex].word)")
            .typography(.heading, color: Color.accent.primary)
    }
    
    // MARK: - Options Grid
    private var optionsGrid: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 2), spacing: 8) {
            ForEach(quiz[currentIndex].options, id: \.self) { option in
                OptionButton(
                    option: option,
                    isCorrect: isCorrect,
                    answer: answer,
                    correctAnswer: quiz[currentIndex].meaning,
                    action: {
                        handleOptionSelection(option: option)
                    }
                )
            }
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - Helper Methods
    private func handleOptionSelection(option: String) {
        withAnimation(.smooth(duration: 0.2)) {
            if quiz[currentIndex].meaning == option {
                isCorrect = true
            } else {
                isCorrect = false
                
                Task {
                    do {
                        let response = try await WordService.search(quiz[currentIndex].word)
                        
                        wrongList.append(response)
                    } catch {
                        print("Error fetching word data: \(error)")
                    }
                }
            }
            answer = option
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isCorrect = nil
            
            withAnimation(.smooth(duration: 0.2)) {
                if currentIndex < quiz.count - 1 { 
                    currentIndex += 1
                } else {
                    Task {
                        do {
                            _ = try await WordService.submitWrongWordQuizResult(incorrect: wrongList.map({ $0.word }))
                            showDetail = true
                        } catch {
                            print("Error submitting quiz result: \(error)")
                        }
                    }
                }
            }
        }
    }
}

struct MemorizeWrongWordResult: View {
    let totalList: [Word]
    let wrongList: [Word]
    
    @EnvironmentObject var bottomBarViewModel: BottomBar.ViewModel
    
    var body: some View {
        ScreenTemplate(scroll: false, titleBar: {
            TitleBar(title: "학습결과 - 자주 틀리는 단어")
        }) {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("이번 학습의 정답률은")
                            .typography(.labelEmphasized, color: Color.content.primary)
                        
                        Text("\(Int((Double(totalList.count - wrongList.count) / Double(totalList.count)) * 100))%입니다")
                            .typography(.titleEmphasized, color: Color.accent.primary)
                    }
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.fill.primary)
                            .cornerRadius(20)
                            .frame(maxWidth: .infinity)
                            .frame(height: 7)
                        Rectangle()
                            .fill(Color.accent.primary)
                            .cornerRadius(20)
                            .frame(maxWidth: .infinity)
                            .frame(height: 7)
                            .scaleEffect(x: Double((totalList.count - wrongList.count)) / Double(totalList.count), y: 1, anchor: .leading)  // scaleEffect 사용
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 24)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("상세 결과")
                        .typography(.labelEmphasized, color: Color.content.primary)
                    
                    ScrollView(.vertical, showsIndicators: true) {
                        HStack(alignment: .top, spacing: 4) {
                            VStack(spacing: 4) {
                                ForEach(totalList) { total in
                                    if !wrongList.contains(where: { $0.id == total.id }) {
                                        VStack(alignment: .leading, spacing: 0) {
                                            Text(total.word)
                                                .typography(.title, color: Color.content.primary)
                                            
                                            Text(total.meanings[0])
                                                .typography(.body, color: Color.content.secondary)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal, 13)
                                        .padding(.vertical, 8)
                                        .background(Color.background.secondary)
                                        .cornerRadius(4)
                                    }
                                }
                            }
                            
                            VStack(spacing: 4) {
                                ForEach(wrongList) { wrong in
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text(wrong.word)
                                            .typography(.title, color: Color.status.danger)
                                        
                                        Text(wrong.meanings[0])
                                            .typography(.body, color: Color.content.secondary)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 13)
                                    .padding(.vertical, 8)
                                    .background(Color(hex: "#F85A5A", alpha: 0.1))
                                    .border(width: 1.5, edges: [.bottom, .leading, .top, .trailing], color: Color.status.danger)
                                    .cornerRadius(4)
                                }
                            }
                        }
                    }
                    .frame(height: 348)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                
                HStack(alignment: .bottom) {
                    Button(action: {
                        bottomBarViewModel.selectedTab = .profile
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                            bottomBarViewModel.selectedTab = .study
                        }
                    }) {
                        Text("끝내기")
                            .typography(.labelEmphasized, color: Color.status.danger)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 14)
                            .background(Color.background.secondary)
                            .cornerRadius(4)
                    }
                }
                .frame(maxHeight: .infinity)
                .padding(.horizontal, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
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

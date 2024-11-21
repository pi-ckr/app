//
//  StudySentence.swift
//  Pickr
//
//  Created by  jwkwon0817 on 11/20/24.
//

import SwiftUI

struct StudySentence: View {
    @Binding var selectedVocabulary: Vocabulary?
    let quiz: [SentenceQuiz]
    @State var currentIndex: Int = 0
    @State var answer: String = ""
    @State var isCorrect: Bool?
    
    @State var wrongList: [Word] = []
    
    @State var showDetail: Bool = false
    
    func handleQuizCompletion() async {
        
        if let selectedVocabulary {
            do {
                _ = try await WordService.submitExampleSentenceQuizResult(
                    selectedVocabulary.name,
                    incorrect: wrongList.map({ $0.word })
                )
                
                showDetail = true
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(.clear)
                    .frame(height: 44)
                VStack(spacing: 19) {
                    VStack(spacing: 44) {
                        VStack(spacing: 13) {
                            Text("\(currentIndex + 1)/\(selectedVocabulary!.words.count)")
                                .typography(.labelEmphasized, color: .white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 6)
                                .background(Color.accent.primary)
                                .cornerRadius(40)
                            
                            Text("빈칸에 들어갈 말을 적어보아요")
                                .typography(.largeTitle, color: Color.content.primary)
                        }
                        
                        VStack(spacing: 18) {
                            HStack(spacing: 0) {
                                Text(quiz[currentIndex].translated.split(separator: "[")[0])
                                    .typography(.headline, color: Color.content.primary)
                                
                                Text(quiz[currentIndex].translated.split(separator: "[")[1].split(separator: "]")[0])
                                    .typography(.headline, color: Color.accent.primary)
                                
                                Text(quiz[currentIndex].translated.split(separator: "]")[1])
                                    .typography(.headline, color: Color.content.primary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 24)
                            .background(Color.accent.transparent)
                            .cornerRadius(12)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                // 첫 번째 부분
                                Text(quiz[currentIndex].quizSentence.split(separator: "[")[0])
                                    .typography(.headline, color: Color.content.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                
                                HStack(spacing: 10) {
                                    TextField("", text: $answer)
                                        .textInputAutocapitalization(.never)
                                        .typography(.headline, color: (isCorrect == nil || isCorrect == true) ?
                                                    Color.accent.primary : Color.status.danger)
                                        .frame(width: CGFloat(quiz[currentIndex].word.count * 10 ))
                                        .frame(height: 27)
                                        .padding(.horizontal, 2)
                                        .background(
                                            (isCorrect == nil || isCorrect == true) ?
                                            Color.accent.transparent : Color(hex: "F85A5A", alpha: 0.1)
                                        )
                                        .cornerRadius(8) // 글자 수에 따른 동적 너비
                                        .onSubmit {
                                            
                                            withAnimation(.smooth(duration: 0.2)) {
                                                isCorrect = answer == quiz[currentIndex].word
                                                
                                                if isCorrect == false {
                                                    Task {
                                                        do {
                                                            let response = try await WordService.search(quiz[currentIndex].word)
                                                            
                                                            wrongList.append(response)
                                                        } catch {
                                                            print("Error fetching word data: \(error)")
                                                        }
                                                    }
                                                }
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                    if currentIndex != quiz.count - 1 {
                                                        currentIndex += 1
                                                    } else {
                                                        Task {
                                                            await handleQuizCompletion()
                                                        }
                                                    }
                                                    
                                                    isCorrect = nil
                                                    
                                                    answer = ""
                                                }
                                            }
                                        }
                                    
                                    // 마지막 부분
                                    Text(quiz[currentIndex].quizSentence.split(separator: "]")[1])
                                        .typography(.headline, color: Color.content.primary)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 24)
                            .background(Color.background.secondary)
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal, 24)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.background.primary)
        .detailNavigation(isPresented: $showDetail) {
            if let selectedVocabulary {
                StudySentenceResult(totalList: selectedVocabulary.words, wrongList: wrongList)
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct StudySentenceResult: View {
    let totalList: [Word]
    let wrongList: [Word]
    
    @EnvironmentObject var bottomBarViewModel: BottomBar.ViewModel
    
    var body: some View {
        ScreenTemplate(scroll: false, titleBar: {
            TitleBar(title: "학습결과 - 예문 맞추기")
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

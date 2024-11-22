//
//  HomeScreen.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/27/24.
//

import SwiftUI

//
//  HomeScreen.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/27/24.
//

import SwiftUI

struct HomeScreen: View {
    
    @EnvironmentObject var viewModel: WordViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ScreenTemplate(titleBar: {
            TitleBar(image: {
                Image("Logo/blue")
                    .renderingMode(.template)
                    .foregroundColor(.accent.primary)
            })
        }) {
            VStack(spacing: 0) {
                VStack(spacing: 27) {
                    VStack(alignment: .leading, spacing: 11) {
                        Text("오늘의 목표")
                            .typography(.heading, color: .content.primary)
                        HStack {
                            ContainerView {
                                Text("30일 넘김")
                                    .typography(.label, color: .accent.primary)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 3)
                            .background(Color.accent.transparent)
                            .cornerRadius(3)
                            ContainerView {
                                Text("일찍 일어나는 새")
                                    .typography(.label, color: .accent.primary)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 3)
                            .background(Color.accent.transparent)
                            .cornerRadius(3)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 8) {
                        HStack {
                            Text("선택됨")
                                .typography(.headlineEmphasized, color: .accent.primary)
                            Spacer()
                            Text("\(viewModel.wordList.count) / 40 단어")
                                .typography(.label, color: .content.secondary)
                        }
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.fill.primary)
                                .cornerRadius(20)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 7)
                            Rectangle()
                                .fill(Color.accent.primary)
                                .cornerRadius(20)
                                .frame(maxWidth: .infinity)
                                .frame(height: 7)
                                .scaleEffect(x: Double(viewModel.wordList.count) / 40, y: 1, anchor: .leading)  // scaleEffect 사용
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.top, 18)
                .padding(.bottom, 36)
                
                VStack(spacing: 20) {
                    HStack {
                        Text("기록")
                            .typography(.title, color: .content.primary)
                        
                        Spacer()
                        
                        HStack(spacing: 10) {
                            HStack(spacing: 3) {
                                Rectangle()
                                    .fill(.fill.secondary)
                                    .cornerRadius(2)
                                    .frame(width: 18, height: 18)
                                Text("0")
                                    .typography(.body, color: .content.secondary)
                                
                            }
                            HStack(spacing: 3) {
                                Rectangle()
                                    .fill(Color.streak.low)
                                    .cornerRadius(2)
                                    .frame(width: 18, height: 18)
                                Text("1-19")
                                    .typography(.body, color: .content.secondary)
                                
                            }
                            HStack(spacing: 3) {
                                Rectangle()
                                    .fill(Color.streak.medium)
                                    .cornerRadius(2)
                                    .frame(width: 18, height: 18)
                                Text("20-29")
                                    .typography(.body, color: .content.secondary)
                                
                            }
                            HStack(spacing: 3) {
                                Rectangle()
                                    .fill(Color.streak.high)
                                    .cornerRadius(2)
                                    .frame(width: 18, height: 18)
                                Text("30-")
                                    .typography(.body, color: .content.secondary)
                                
                            }
                        }
                    }
                    
                    HStack(spacing: 2) {
                        if let me = authViewModel.me {
                            ForEach(me.grass, id: \.self) { historyWeek in
                                VStack(spacing: 2) {
                                    ForEach(historyWeek, id: \.self) { historyToday in
                                        Rectangle()
                                            .fill(
                                                historyToday == 0 ? Color.fill.secondary :
                                                    historyToday <= 19 ? Color.streak.low :
                                                    historyToday <= 29 ? Color.streak.medium :
                                                    Color.streak.high
                                            )
                                            .frame(maxWidth: .infinity)
                                            .aspectRatio(1.0, contentMode: .fit)
                                            .cornerRadius(2)
                                    }
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.vertical, 26)
                .background(Color.background.secondary)
                
                VStack(spacing: 22) {
                    HStack {
                        Text("픽한 리스트")
                            .typography(.title, color: .content.primary)
                         
                        Spacer()
                        
                        Text("\(viewModel.wordList.count)")
                            .typography(.title, color: .accent.primary)
                    }
                    .frame(maxWidth: .infinity)
                    
                    LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 4), count: 2), spacing: 4) {
                        ForEach(viewModel.wordList) { word in
                            VStack(alignment: .leading, spacing: 0) {
                                Text(word.word)
                                    .typography(.title, color: Color.content.primary)
                                
                                Text(word.meanings[0])
                                    .typography(.body, color: Color.content.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 13)
                            .padding(.vertical, 8)
                            .background(Color.fill.secondary)
                            .cornerRadius(4)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.top, 26)
                .padding(.bottom, 180)
                .background(Color.background.tertiary)
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

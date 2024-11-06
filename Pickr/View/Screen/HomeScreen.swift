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
    let history = [
       [4, 15, 28, 12, 7, 22, 35],
       [18, 3, 31, 9, 25, 14, 29],
       [8, 21, 16, 33, 5, 27, 11],
       [30, 6, 19, 2, 34, 13, 24],
       [17, 32, 10, 26, 1, 36, 20],
       [12, 25, 38, 7, 19, 33, 15],
       [22, 4, 29, 16, 31, 9, 37],
       [5, 28, 13, 35, 2, 24, 18],
       [33, 11, 26, 8, 39, 17, 30],
       [15, 34, 6, 23, 3, 40, 21],
       [28, 7, 35, 14, 27, 10, 32],
       [13, 36, 4, 29, 12, 38, 16],
       [25, 9, 31, 5, 22, 15, 37],
       [19, 33, 8, 40, 11, 26, 14],
       [6, 30, 17, 2, 35, 20, 28],
       [38, 12, 24, 7, 31, 16, 33],
       [10, 27, 3, 36, 14, 29, 19],
       [21, 5, 32, 18, 40, 9, 25]
    ]
    
    let words = [
        Word(english: "practice", korean: "연습하다"),
        Word(english: "design", korean: "설계하다"),
        Word(english: "goal", korean: "목표"),
        Word(english: "galaxy", korean: "은하수"),
        Word(english: "test", korean: "테스트"),
        Word(english: "test", korean: "테스트"),
        Word(english: "test", korean: "테스트"),
        Word(english: "test", korean: "테스트"),
        Word(english: "test", korean: "테스트"),
        Word(english: "test", korean: "테스트"),
        Word(english: "test", korean: "테스트"),
        
    ]
    
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
                            Text("36 / 40 단어")
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
                                .scaleEffect(x: 36/40, y: 1, anchor: .leading)  // scaleEffect 사용
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
                        ForEach(history, id: \.self) { historyWeek in
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
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.vertical, 26)
                .background(Color.background.secondary)
                
                VStack(spacing: 22) {
                    HStack {
                        Text("픽한 리스트")
                            .typography(.title, color: .content.primary)
                        
                        Spacer()
                        
                        Text("\(words.count)")
                            .typography(.title, color: .accent.primary)
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack(spacing: 4) {
                        ForEach(0..<(words.count + 1) / 2, id: \.self) { row in
                            HStack(spacing: 4) {
                                ForEach(0..<2) { column in
                                    let index = row * 2 + column
                                    if index < words.count {
                                        VStack(alignment: .leading, spacing: 0) {
                                            Text(words[index].english)
                                                .typography(.headlineEmphasized, color: .content.primary)
                                            Text(words[index].korean)
                                                .typography(.footnote, color: .content.secondary)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal, 13)
                                        .padding(.vertical, 8)
                                        .background(Color.fill.secondary)
                                        .cornerRadius(4)
                                    } else {
                                        // 빈 공간을 채우기 위한 투명한 뷰
                                        Color.clear
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.top, 26)
                .padding(.bottom, 116)
                .background(Color.background.tertiary)
            }
        }
    }
}

#Preview {
    HomeScreen()
        .environmentObject(BottomBar.ViewModel())
}

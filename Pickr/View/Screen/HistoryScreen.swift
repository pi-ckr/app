//
//  HomeScreen.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/27/24.
//

import SwiftUI
import Charts

struct HistoryScreen: View {
    let dateManager = DateManager()
    
    private var today: String {
        return dateManager.getCurrentDateKorean()
    }
    
    private var dateRange: [DateInfo] {
        return dateManager.getDateRange(offsetDays: 3)
    }
    
    @EnvironmentObject var wordViewModel: WordViewModel

    
    // DateItem을 별도의 뷰로 분리
    private struct DateItem: View {
        let date: DateInfo
        let isCenter: Bool
        let isSide: Bool
        let weekdayString: String
        
        var body: some View {
            VStack {
                Text(weekdayString)
                    .typography(.label, color: isSide ? .content.secondary : .content.primary)
                Text("\(date.date)")
                    .typography(.labelEmphasized, color: isSide ? .content.secondary : isCenter ? .white : .content.primary)
                    .frame(width: 44, height: 44)
                    .background(isCenter ? Color.accent.primary : .clear)
                    .clipShape(Circle())
            }
        }
    }
    
    var body: some View {
        ScreenTemplate(titleBar: {
            TitleBar(title: "학습 기록")
        }) {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 20) {
                    Text(today)
                        .typography(.headlineEmphasized, color: .content.primary)
                        .padding(.leading, 20)
                    
                    HStack {
                        Spacer()
                        
                        ForEach(Array(dateRange.enumerated()), id: \.element.id) { index, date in
                            DateItem(
                                date: date,
                                isCenter: index == dateRange.count / 2,
                                isSide: index == 0 || index == dateRange.count - 1,
                                weekdayString: dateManager.weekdayString(from: date.day)
                            )
                            
                            if index < dateRange.count - 1 {
                                Spacer()
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 11)
                }
                .padding(.vertical, 18)
                .background(Color.background.primary)
                
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("이날의 통계")
                            .typography(.titleEmphasized, color: .content.primary)
                        
                        HStack(spacing: 20) {
                            if let history = wordViewModel.history {
                                Chart {
                                    SectorMark(
                                        angle: .value(
                                            "오답",
                                            Int(history.incorrectRate * 100)
                                        )
                                    )
                                    .foregroundStyle(Color.status.danger)
                                    
                                    SectorMark(
                                        angle: .value(
                                            "정답",
                                            Int(history.correctRate * 100)
                                        )
                                    )
                                    .foregroundStyle(Color.accent.primary)
                                }
                                .scaledToFit()
                                .frame(width: 87, height: 87)
                            }
                            
                            VStack(spacing: 4) {
                                HStack(spacing: 8) {
                                    Rectangle()
                                        .fill(Color.status.danger)
                                        .frame(width: 10, height: 10)
                                    
                                    Text("오답")
                                        .typography(.bodyEmphasized, color: Color.content.primary)
                                }
                                
                                HStack(spacing: 8) {
                                    Rectangle()
                                        .fill(Color.accent.primary)
                                        .frame(width: 10, height: 10)
                                    
                                    Text("정답")
                                        .typography(.bodyEmphasized, color: Color.content.primary)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Group {
                        Rectangle()
                            .fill(Color.background.tertiary)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(30)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("단어 외우기 기록")
                            .typography(.titleEmphasized, color: .content.primary)
                        
                        ScrollView(.horizontal, showsIndicators: true) {
                            HStack(spacing: 10) {
                                if let history = wordViewModel.history {
                                    
                                    ForEach(history.memorizeWords.indices, id: \.self) { index in
                                        let rate = Int(round(history.incorrectRate * 10000) / 100)
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("단어 외우기 \(index + 1)회")
                                                .typography(.labelEmphasized, color: .content.primary)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                            Text("정답률 \(rate)%")
                                                .typography(.body, color: Color.content.secondary)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 12)
                                        .frame(width: 171)
                                        .background(Color.background.tertiary)
                                        .clipShape(
                                            RoundedCorner(radius: 4)
                                        )
                                    }
                                }
                            }
                        }
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    ForEach(["예문 맞추기", "자주 틀리는 단어", "스토리텔링"], id: \.self) { text in
                        VStack(alignment: .leading, spacing: 12) {
                            Text("\(text) 기록")
                                .typography(.title, color: Color.content.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                            Text("이 날의 학습 기록이 없습니다.")
                                .typography(.body, color: Color.content.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.vertical, 12)
                .background(Color.background.secondary)
            }
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

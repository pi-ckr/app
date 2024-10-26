//
//  OnBoardView.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/3/24.
//

import SwiftUI

enum OnboardStep {
    case first, second, third, login
}

struct Progress: View {
    let order: Int

    init(order: Int) {
        self.order = max(1, min(order, 5))
    }
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(1...5, id: \.self) {
                Rectangle()
                    .frame(width: $0 == order ? 24 : 9, height: 9)
                    .foregroundColor($0 == order ? .accent.primary : .background.tertiary)
                    .cornerRadius(40)
            }
        }
        .animation(.easeInOut, value: order)
    }
}

struct OnboardView: View {
    @State private var step: OnboardStep = .first
    
    
    var body: some View {
        VStack {
            dynamicContent(for: step)
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                .animation(.easeInOut, value: step)
            Spacer()
            VStack(spacing: 32) {
                Progress(order: dynamicOrder(for: step))
                Button(action: dynamicButtonAction(for: step)) {
                    HStack(spacing: 8) {
                        Text(step == .login ? "로그인" : "다음")
                            .typography(.headlineEmphasized, color: .content.primary)
                        Image("arrow_forward")
                            .renderingMode(.template)
                            .foregroundColor(.content.primary)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .frame(maxWidth: .infinity, maxHeight: 58)
                .background(Color.accent.transparent)
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.accent.primary),
                    alignment: .bottom
                )
            }
            .padding(.bottom, 21)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 24)
    }
    
    @ViewBuilder
    func dynamicContent(for step: OnboardStep) -> some View {
        switch step {
        case .first:
            OnboardFirst()
        case .second:
            OnboardSecond()
        case .third:
            OnboardThird()
        case .login:
            OnboardLogin()
        }
    }
    
    func dynamicOrder(for step: OnboardStep) -> Int {
        let dict: [OnboardStep: Int] = [.first: 1, .second: 2, .third: 3, .login: 4]
        return dict[step] ?? 1
    }
    
    func dynamicButtonAction(for step: OnboardStep) -> () -> Void {
        return {
            withAnimation {
                switch step {
                case .first:
                    self.step = .second
                case .second:
                    self.step = .third
                case .third:
                    self.step = .login
                case .login:
                    self.step = .first
                }
            }
        }
    }
}
 
#Preview {
    OnboardView()
}

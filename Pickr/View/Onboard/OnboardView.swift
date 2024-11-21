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
        self.order = max(1, min(order, 3))
    }
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(1...3, id: \.self) {
                Rectangle()
                    .frame(width: $0 == order ? 24 : 8, height: 8)
                    .foregroundColor($0 == order ? .accent.primary : .border.secondary)
                    .cornerRadius(40)
            }
        }
        .animation(.easeInOut, value: order)
    }
}

struct OnboardView: View {
    @StateObject var viewModel: ViewModel
    @EnvironmentObject var mainViewModel: ContentView.ViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    init(loginStepAction: @escaping () -> Void) {
        // thirdStepAction을 직접 클로저로 전달
        _viewModel = StateObject(wrappedValue: ViewModel(loginStepAction: loginStepAction))
    }

    
    var body: some View {
        VStack(spacing: 47) {
            Spacer()
            VStack {
                VStack(spacing: 70) {
                    ZStack {
                        Image(dynamicIcon(for: viewModel.step))
                            .renderingMode(.template)
                            .foregroundColor(.content.primary)
                        }
                        .transition(
                            .asymmetric(
                                insertion: .opacity.combined(with: .offset(x: 10)),
                                removal: .opacity.combined(with: .offset(x: -10))
                            )
                        )
                        .animation(.smooth(duration: 0.4), value: viewModel.step)
                        .id(viewModel.step)
                    VStack(alignment: .leading, spacing: 24) {
                        Progress(order: viewModel.getOrder())
                        dynamicContent(for: viewModel.step)
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading).combined(with: .opacity)))
                            .animation(.smooth(duration: 0.4), value: viewModel.step)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                }
            }
            .frame(maxWidth: .infinity)
            VStack(spacing: 0) {
                Button(action: {
                    if viewModel.step == .third {
                        authViewModel.login(username: "dlfjstizlzl", password: "dlfjstizlzl")
                    }
                    
                    viewModel.moveToNextStep()
                }) {
                        HStack(spacing: 8) {
                            Button(action: {
                                withAnimation {
                                    mainViewModel.hideOnboard()
                                }
                            }) {
                                Text("스킵하기")
                                    .typography(.headline, color: Color(hex: "#ffffff", alpha: 0.6))
                            }
                            Spacer() 
                            Text(viewModel.step == .third ? "시작하기" : "계속 알아보기")
                                .typography(.title, color: Color("System/White"))
                                .animation(.none, value: viewModel.step)
                            Image("Icon/arrow_forward")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color("System/White"))
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 21)
                        
                    }
                    .ignoresSafeArea(.container, edges: .bottom)
                }
                .background(Color.accent.primary)
                .ignoresSafeArea(.all, edges: .bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
    
    func dynamicIcon(for step: OnboardStep) -> String {
        switch step {
        case .first:
            return "Cursor"
        case .second:
            return "Calendar"
        case .third:
            return "Robot"
        case .login:
            return "Robot"
        }
    }
}

#Preview {
    OnboardView(loginStepAction: {})
        .environmentObject(ContentView.ViewModel())
}

//
//  OnboardLogin.swift
//  Pickr
//
//  Created by  jwkwon0817 on 11/11/24.
//

import SwiftUI

struct OnboardLogin: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var showLogin: Bool = false
    @State var showRegister: Bool = false
    
    var body: some View {
        if showLogin {
            OnboardLoginPage()
        } else if showRegister {
            OnboardSignupPage()
        } else {
            VStack {
                Spacer()
                
                VStack(spacing: 68) {
                    VStack(spacing: 40) {
                        Image("Cursor")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                            .foregroundStyle(Color.content.primary)
                        
                        VStack(spacing: 23) {
                            Image("Logo/Pickr")
                                .renderingMode(.template)
                                .foregroundStyle(Color.content.primary)
                            
                            Text("내 맘대로 픽해서 공부하는 영단어")
                                .typography(.headlineEmphasized, color: Color.content.primary)
                        }
                    }
                    
                    VStack(spacing: 30) {
                        VStack(spacing: 20) {
                            HStack {
                                Button(action: {
                                    showLogin.toggle()
                                }) {
                                    HStack(spacing: 10) {
                                        Image("Icon/mail")
                                            .renderingMode(.template)
                                            .foregroundStyle(Color.content.primary)
                                        Text("이메일로 계속하기")
                                            .typography(.labelEmphasized, color: Color.content.primary)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 16)
                                    .background(Color.background.secondary)
                                    .cornerRadius(4)
                                }
                            }
                            .padding(.horizontal, 20)
                            
                            Button(action: {
                                showRegister.toggle()
                            }) {
                                Text("계정이 생각나지 않아요")
                                    .typography(.body, color: Color.content.secondary)
                                    .underline()
                            }
                        }
                        
                        Button(action: {
                            withAnimation(.smooth(duration: 0.2)) {
                                showLogin.toggle()
                            }
                        }) {
                            HStack(spacing: 8) {
                                Text("휴대폰 번호로 계속하기")
                                    .typography(.headlineEmphasized, color: .white)
                                
                                Image("Icon/arrow_forward")
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(Color("System/White"))
                            }
                            .padding(20)
                            .frame(maxWidth: .infinity)
                            .background(Color.accent.primary)
                        }
                    }
                }
            }
            .background(Color.background.primary)
        }
    }
}
 
#Preview {
    OnboardLogin()
}

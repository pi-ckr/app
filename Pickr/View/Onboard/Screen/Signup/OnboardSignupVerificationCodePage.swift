//
//  OnboardLoginVerificationCodePage.swift
//  Pickr
//
//  Created by  jwkwon0817 on 11/22/24.
//

import SwiftUI

struct OnboardSignupVerificationCodePage: View {
    @State var code: String = ""
    @State var time: Int = 180
    @State var timer: Timer? = nil
    
    
    @Binding var selection: Int
    let phoneNumber: String
    @Binding var accessKey: String
    
    var formattedTime: String {
       String(format: "%02d분 %02d초", time / 60, time % 60)
    }

    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(.clear)
                .frame(height: 78)
            VStack(alignment: .leading, spacing: 31) {
                Text("인증번호를 입력해 주세요")
                    .typography(.largeTitle, color: Color.content.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading, spacing: 10) {
                    Text("인증번호")
                        .typography(.label, color: Color.content.primary)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        TextField("", text: $code)
                            .padding(.vertical, 12)
                            .border(width: 1, edges: [.bottom], color: Color.border.primary)
                            .textContentType(.oneTimeCode)
                            .keyboardType(.numberPad)
                            .onChange(of: code) { _, newValue in
                                if newValue.count > 6 {
                                    code = String(newValue.prefix(6))
                                }
                            }
                        
                        HStack(spacing: 8) {
                            Text(formattedTime + " 남음")
                                .typography(.label, color: Color.content.secondary)
                            
                            Button(action: {
                                Task {
                                    _ = try await AuthService.smsVerifiy(phoneNumber)
                                }
                            }) {
                                Text("인증번호 재전송")
                                    .typography(.labelEmphasized, color: Color.accent.primary)
                                    .underline()
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Button(action: {
                    Task {
                        let response = try await AuthService.smsConfirm(phoneNumber, code: code)
                        
                        accessKey = response.accessKey
                    }
                    selection = 4
                }) {
                    Image("Icon/arrow_forward")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.white)
                        .frame(width: 54, height: 54)
                        .background(code.count != 6 ? Color.fill.primary : Color.accent.primary)
                        .cornerRadius(2)
                }
                .disabled(code.count != 6)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 40)
            .padding(.bottom, 39)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.primary)
        .onAppear {
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private func startTimer() {
       timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
           if time > 0 {
               time -= 1
           } else {
               timer?.invalidate()
               // 시간 종료 시 처리할 로직
           }
       }
    }
}

#Preview {
    OnboardSignupVerificationCodePage(selection: .constant(1), phoneNumber: "", accessKey: .constant(""))
}

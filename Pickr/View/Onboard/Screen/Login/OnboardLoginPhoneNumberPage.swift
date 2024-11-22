//
//  OnboardLoginPhoneNumberPage.swift
//  Pickr
//
//  Created by  jwkwon0817 on 11/22/24.
//

import SwiftUI

struct OnboardLoginPhoneNumberPage: View {
    @Binding var selection: Int
    
    @Binding var phoneNumber: String
    @State var birth: String = ""
    @State var gender: String = ""
    @Binding var username: String
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(.clear)
                .frame(height: 78)
            VStack(alignment: .leading, spacing: 48) {
                Text("전화번호를 입력해 주세요")
                    .typography(.largeTitle, color: Color.content.primary)
                
                VStack(spacing: 32) {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 4) {
                            Text("전화번호")
                                .typography(.label, color: Color.content.primary)
                            Text("*")
                                .typography(.label, color: Color.status.danger)
                        }
                        
                        HStack(spacing: 12) {
                            TextField("010-0000-0000", text: $phoneNumber)
                                .padding(.vertical, 12)
                                .border(width: 1, edges: [.bottom], color: Color.border.primary)
                                .keyboardType(.numberPad)
                                .onChange(of: phoneNumber) { _, newValue in
                                    if newValue.count > 11 {
                                        phoneNumber = String(newValue.prefix(11))
                                    }
                                }
                            
                            Button(action: {
                                
                                Task {
                                    _ = try await AuthService.smsVerifiy(phoneNumber)
                                    
                                    selection = 1
                                }
                            }) {
                                Text("인증하기")
                                    .typography(.labelEmphasized, color: Color.content.primary)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 12)
                                    .background(!phoneNumber.isEmpty && !birth.isEmpty && !gender.isEmpty && !username.isEmpty ? Color.accent.primary : Color.fill.primary)
                                    .cornerRadius(2)
                            }
                            .disabled(phoneNumber.isEmpty || birth.isEmpty || gender.isEmpty || username.isEmpty)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 4) {
                            Text("생년월일")
                                .typography(.label, color: Color.content.primary)
                            Text("*")
                                .typography(.label, color: Color.status.danger)
                        }
                        
                        HStack(spacing: 26) {
                            TextField("000000", text: $birth)
                                .frame(width: 154)
                                .padding(.vertical, 12)
                                .border(width: 1, edges: [.bottom], color: Color.border.primary)
                                .keyboardType(.numberPad)
                                .onChange(of: birth) { _, newValue in
                                    if newValue.count > 6 {
                                        birth = String(newValue.prefix(6))
                                    }
                                }
                            
                            
                            Text("-")
                                .typography(.labelEmphasized, color: Color.content.primary)
                            
                            TextField("0", text: $gender)
                                .frame(width: 41)
                                .padding(.vertical, 12)
                                .border(width: 1, edges: [.bottom], color: Color.border.primary)
                                .keyboardType(.numberPad)
                                .onChange(of: gender) { _, newValue in
                                    if newValue.count > 1 {
                                        gender = String(newValue.prefix(1))
                                    }
                                }
                            
                            Text("* * * * * *")
                                .typography(.labelEmphasized, color: Color.content.primary)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 4) {
                            Text("사용자 이름")
                                .typography(.label, color: Color.content.primary)
                            Text("*")
                                .typography(.label, color: Color.status.danger)
                        }
                        
                        TextField("", text: $username)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .border(width: 1, edges: [.bottom], color: Color.border.primary)
                            .textInputAutocapitalization(.never)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.background.primary)
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardLoginPhoneNumberPage(selection: .constant(0), phoneNumber: .constant(""), username: .constant(""))
}

//
//  OnboardLoginVerificationCodePage 2.swift
//  Pickr
//
//  Created by  jwkwon0817 on 11/22/24.
//


//
//  OnboardLoginVerificationCodePage.swift
//  Pickr
//
//  Created by  jwkwon0817 on 11/22/24.
//

import SwiftUI

struct OnboardSignupDatePage: View {
    
    @Binding var selection: Int
    
    @Binding var birth: String
    @Binding var gender: String
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(.clear)
                .frame(height: 78)
            VStack(alignment: .leading, spacing: 31) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("생년월일을 포함하여")
                        .typography(.largeTitle, color: Color.content.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("앞 7자리를 입력해주세요")
                        .typography(.largeTitle, color: Color.content.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
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
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Button(action: {
                    selection = 2
                }) {
                    Image("Icon/arrow_forward")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.white)
                        .frame(width: 54, height: 54)
                        .background(birth.isEmpty || gender.isEmpty ? Color.fill.primary : Color.accent.primary)
                        .cornerRadius(2)
                }
                .disabled(birth.isEmpty || gender.isEmpty)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 40)
            .padding(.bottom, 39)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.primary)
    }
}

#Preview {
    OnboardSignupDatePage(selection: .constant(2), birth: .constant(""), gender: .constant(""))
}

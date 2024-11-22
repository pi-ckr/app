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

struct OnboardSignupUsernamePage: View {
    
    @Binding var selection: Int
    @Binding var username: String
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(.clear)
                .frame(height: 78)
            VStack(alignment: .leading, spacing: 31) {
                Text("이름을 알려주세요")
                    .typography(.largeTitle, color: Color.content.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading, spacing: 10) {
                    Text("사용자 이름")
                        .typography(.label, color: Color.content.primary)
                    
                    TextField("", text: $username)
                        .padding(.vertical, 12)
                        .border(width: 1, edges: [.bottom], color: Color.border.primary)
                        .textInputAutocapitalization(.never)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Button(action: {
                    selection = 1
                }) {
                    Image("Icon/arrow_forward")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.white)
                        .frame(width: 54, height: 54)
                        .background(username.isEmpty ? Color.fill.primary : Color.accent.primary)
                        .cornerRadius(2)
                }
                .disabled(username.isEmpty)
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
    OnboardSignupUsernamePage(selection: .constant(0), username: .constant(""))
}

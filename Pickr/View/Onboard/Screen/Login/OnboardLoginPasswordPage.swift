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

struct OnboardLoginPasswordPage: View {
    
    @Binding var selection: Int
    @Binding var username: String
    @Binding var password: String
    
    let phoneNumber: String
    let accessKey: String
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(.clear)
                .frame(height: 78)
            VStack(alignment: .leading, spacing: 31) {
                Text("비밀번호를 입력해 주세요")
                    .typography(.largeTitle, color: Color.content.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading, spacing: 10) {
                    Text("비밀번호")
                        .typography(.label, color: Color.content.primary)
                    
                    TextField("", text: $password)
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
                    Task {
                        try await authViewModel.login(username: username, password: password, phoneNumber: phoneNumber, accessKey: accessKey)
                    }
                }) {
                    Image("Icon/arrow_forward")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.white)
                        .frame(width: 54, height: 54)
                        .background(Color.accent.primary)
                        .cornerRadius(2)
                }
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
    OnboardLoginPasswordPage(selection: .constant(2), username: .constant(""), password: .constant(""), phoneNumber: "", accessKey: "")
        .environmentObject(AuthViewModel())
}

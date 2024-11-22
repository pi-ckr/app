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

struct OnboardSignupPasswordPage: View {
    
    @Binding var selection: Int
    @Binding var password: String
    
    @State var passwordConfirm: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(.clear)
                .frame(height: 78)
            VStack(alignment: .leading, spacing: 31) {
                Text("비밀번호를 설정해 주세요")
                    .typography(.largeTitle, color: Color.content.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                VStack(spacing: 26) {
                    PasswordField(password: $password, title: "비밀번호")
                    
                    PasswordField(password: $passwordConfirm, title: "비밀번호 확인")
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Button(action: {
                    selection = 5
                }) {
                    Image("Icon/arrow_forward")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.white)
                        .frame(width: 54, height: 54)
                        .background(password != passwordConfirm ? Color.fill.primary : Color.accent.primary)
                        .cornerRadius(2)
                }
                .disabled(password != passwordConfirm)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 40)
            .padding(.bottom, 39)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.primary)
    }
}

struct PasswordField: View {
   @Binding var password: String
   let title: String
   @State private var isSecure: Bool = true
   
   var body: some View {
       VStack(alignment: .leading, spacing: 10) {
           Text(title)
               .typography(.label, color: Color.content.primary)
           
           HStack {
               if isSecure {
                   SecureField("", text: $password)
                       .padding(.vertical, 12)
               } else {
                   TextField("", text: $password)
                       .padding(.vertical, 12)
               }
               
               Button(action: {
                   isSecure.toggle()
               }) {
                   Image(systemName: isSecure ? "eye.slash" : "eye")
                       .foregroundColor(Color.content.secondary)
               }
           }
           .border(width: 1, edges: [.bottom], color: Color.border.primary)
           .textInputAutocapitalization(.never)
       }
   }
}

#Preview {
    OnboardSignupPasswordPage(selection: .constant(2), password: .constant(""))
}

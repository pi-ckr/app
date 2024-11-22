//
//  OnboardLoginPage.swift
//  Pickr
//
//  Created by  jwkwon0817 on 11/22/24.
//

import SwiftUI

struct OnboardLoginPage: View {
    @State var selection: Int = 0
    
    @State var phoneNumber: String = ""
    @State var username: String = ""
    @State var password: String = ""
    
    @State var accessKey: String = ""
    
    var body: some View {
        TabView(selection: $selection) {
            OnboardLoginPhoneNumberPage(selection: $selection, phoneNumber: $phoneNumber, username: $username)
                .tag(0)
            
            OnboardLoginVerificationCodePage(selection: $selection, phoneNumber: phoneNumber, accessKey: $accessKey)
                .tag(1)
            
            OnboardLoginPasswordPage(selection: $selection, username: $username, password: $password, phoneNumber: phoneNumber, accessKey: accessKey)
                .tag(2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardLoginPage()
}

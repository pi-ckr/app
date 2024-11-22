//
//  OnboardLoginPage.swift
//  Pickr
//
//  Created by  jwkwon0817 on 11/22/24.
//

import SwiftUI

struct OnboardSignupPage: View {
   @State var selection: Int = 0
   
   @State var phoneNumber: String = ""
   @State var username: String = ""
   @State var password: String = ""
   @State var profileImage: String = ""
    
    @State var birth: String = ""
    @State var gender: String = ""
   
   @State var accessKey: String = ""
   
   var body: some View {
       VStack {
           switch selection {
           case 0:
               OnboardSignupUsernamePage(selection: $selection, username: $username)
           case 1:
               OnboardSignupDatePage(selection: $selection, birth: $birth, gender: $gender)
           case 2:
               OnboardSignupPhoneNumberPage(selection: $selection, phoneNumber: $phoneNumber)
           case 3:
               OnboardSignupVerificationCodePage(selection: $selection, phoneNumber: phoneNumber, accessKey: $accessKey)
           case 4:
               OnboardSignupPasswordPage(selection: $selection, password: $password)
           case 5:
               OnboardSignupImagePage(selection: $selection, username: $username, password: $password, birth: $birth, gender: $gender, phoneNumber: $phoneNumber, profileImage: $profileImage, accessKey: $accessKey)
           default:
               EmptyView()
           }
       }
       .frame(maxWidth: .infinity, maxHeight: .infinity)
   }
}

#Preview {
    OnboardSignupPage()
}

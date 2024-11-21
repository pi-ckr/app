//
//  OnboardLogin.swift
//  Pickr
//
//  Created by  jwkwon0817 on 11/11/24.
//

import SwiftUI

struct OnboardLogin: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Button(action: {
            authViewModel.login(username: "dlfjstizlzl", password: "dlfjstizlzl")
        }) {
            Text("")
        }
    }
}

#Preview {
    OnboardLogin()
}

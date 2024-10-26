
//
//  OnboardViewModel.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/26/24.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var isShowingOnboard: Bool = true
    
    func hideOnboard() {
        if isShowingOnboard {
            isShowingOnboard = false
        }
    }
}

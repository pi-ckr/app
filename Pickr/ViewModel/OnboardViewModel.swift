//
//  OnboardViewModel.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/26/24.
//

import SwiftUI

class OnboardViewModel: ObservableObject {
    @Published var step: OnboardStep = .first
    var mainViewModel: MainViewModel
    
    init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
    }
    
    func moveToNextStep() {
        withAnimation {
            switch step {
            case .first:
                step = .second
            case .second:
                step = .third
            case .third:
                mainViewModel.hideOnboard()
            }
        }
    }
    
    func getOrder() -> Int {
        let dict: [OnboardStep: Int] = [.first: 1, .second: 2, .third: 3]
        return dict[step] ?? 1
    }
}

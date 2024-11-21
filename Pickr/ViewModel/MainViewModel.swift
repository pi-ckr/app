
//
//  OnboardViewModel.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/26/24.
//

import SwiftUI

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var isShowingOnboard: Bool = true
        
        init() {
            NotificationCenter.default.addObserver(self, selector: #selector(hideOnboardShowing), name: .userDidAuthenticate, object: nil)
        }
        
        func hideOnboard() {
            if isShowingOnboard {
                isShowingOnboard = false
            }
        }
        
        @objc private func hideOnboardShowing() {
            isShowingOnboard = false
        }
    }
}

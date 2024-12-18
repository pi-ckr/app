//
//  BottomBarViewModel.swift
//  Pickr
//
//  Created by jwkwon0817 on 10/26/24.
//

import SwiftUI

enum Tab {
    case home, vocabulary, study, history, profile
    
    var iconName: String {
        switch self {
        case .home:
            return "home"
        case .vocabulary:
            return "vocabulary"
        case .study:
            return "study"
        case .history:
            return "history"
        case .profile:
            return "profile"
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .vocabulary:
            return "단어장"
        case .study:
            return "학습"
        case .history:
            return "기록"
        case .profile:
            return "내정보"
        }
    }
}

extension BottomBar {
    class ViewModel: ObservableObject {
        @Published var selectedTab: Tab = .home
        let tabs: [Tab] = [.home, .vocabulary, .study, .history, .profile]
        
        func switchTab(to tab: Tab) {
            selectedTab = tab
        }
    }
}

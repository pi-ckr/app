//
//  ScreenTemplate.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/29/24.
//

import SwiftUI

struct ScreenTemplate<Content: View>: View {
    var backgroundColor: Color = .background.primary
    var scroll: Bool = true
    
    var titleBar: () -> TitleBar
    
    @ViewBuilder var content: () -> Content
    @EnvironmentObject var bottomBarViewModel: BottomBar.ViewModel
    @EnvironmentObject var wordViewModel: WordViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            titleBar()
            
            if scroll {
                ScrollViewReader { scrollProxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(.clear)
                                .frame(height: 56)
                                .zIndex(0)
                                .id("ScreenTemplate-Top")
                            
                            content()
                        }
                    }
                    .refreshable {
                        wordViewModel.fetchVocabularyList()
                        wordViewModel.fetchWords()
                    }
                    .onChange(of: bottomBarViewModel.selectedTab) { oldValue, newValue in
                        scrollProxy.scrollTo("ScreenTemplate-Top")
                    }
                }
            } else {
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 56)
                        .zIndex(0)
                    content()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
    }
}

#Preview {
    ContentView()
        .environmentObject(ContentView.ViewModel())
        .environmentObject(OnboardView.ViewModel(loginStepAction: {}))
        .environmentObject(BottomBar.ViewModel())
        .environmentObject(AuthViewModel())
        .environmentObject(WordViewModel())
}

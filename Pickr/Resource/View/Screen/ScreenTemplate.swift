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
    
    @State private var scrollId = UUID()
    @EnvironmentObject var bottomBarViewModel: BottomBar.ViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            titleBar()
            
            if scroll {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        Rectangle()
                            .fill(.clear)
                            .frame(height: 56)
                            .zIndex(0)
                        
                        content()
                    }
                }
                .id(scrollId)
            } else {
                content()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all, edges: .bottom)
        .background(backgroundColor)
        .onChange(of: bottomBarViewModel.selectedTab) { _, _ in
            scrollId = UUID()
        }
    }
}

#Preview {
    ScreenTemplate(titleBar: {
        TitleBar(title: "Title", icon: {
            Image("Icon/plus")
        })
    }) {
        
    }
    .environmentObject(BottomBar.ViewModel())
}

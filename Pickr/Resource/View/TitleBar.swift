//
//  TitleBar.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/29/24.
//

import SwiftUI

struct TitleBar: View {
    var title: String?
    
    var icon: (() -> any View)? = nil
    var image: (() -> any View)? = nil
    
    var action: () -> Void = {}
    
    var body: some View {
        ZStack {
            Color.background.primary.opacity(0.8)
                .ignoresSafeArea(.all, edges: [.top])
                .background(.ultraThinMaterial)
                .clipShape(
                    Rectangle()
                )
                .ignoresSafeArea(.all, edges: [.top])
            
            HStack {
                if let image = image {
                    AnyView(image())
                } else if let title = title {
                    Text(title)
                        .typography(.title, color: .content.primary)
                }
                
                if let icon = icon {
                    Spacer()
                    
                    Button(action: action) {
                        AnyView(icon())
                    }
                    .frame(width: 48, height: 48)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: icon != nil ? .center : .leading)
            .padding(.leading, 20)
            .padding(.trailing, icon == nil ? 0 : 4)
            .zIndex(1)
        }
        .frame(maxWidth: .infinity, maxHeight: 56)
        .zIndex(1)
    }
}

#Preview {
    HomeScreen()
        .environmentObject(BottomBar.ViewModel())
}

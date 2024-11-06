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
    var leftIcon: (() -> any View)? = nil
    var image: (() -> any View)? = nil
    
    var action: () -> Void = {}
    var leftAction: () -> Void = {}
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.background.primary.opacity(0.8)
                .ignoresSafeArea(.all, edges: [.top])
                .background(.ultraThinMaterial)
                
            
            HStack {
                if let image = image {
                    if let leftIcon {
                        HStack(spacing: 0) {
                            Button(action: leftAction) {
                                AnyView(leftIcon())
                            }
                            .frame(width: 48, height: 48)
                            AnyView(image())
                        }
                    } else {
                        AnyView(image())
                    }
                } else if let title = title {
                    if let leftIcon {
                        HStack(spacing: 0) {
                            Button(action: leftAction) {
                                AnyView(leftIcon())
                            }
                            .frame(width: 48, height: 48)
                            Text(title)
                                .typography(.title, color: .content.primary)
                        }
                    } else {
                        Text(title)
                            .typography(.title, color: .content.primary)
                    }
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
            .padding(.leading, leftIcon == nil ? 20 : 4)
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

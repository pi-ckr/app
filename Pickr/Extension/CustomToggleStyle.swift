//
//  MyToggleStyle.swift
//  Pickr
//
//  Created by  jwkwon0817 on 11/7/24.
//
import SwiftUI

struct CustomToggleStyle: ToggleStyle {
  
  func makeBody(configuration: Configuration) -> some View {
    HStack {
        configuration.label
        
        Spacer()
        
        ZStack(alignment: configuration.isOn ? .trailing : .leading) {
            RoundedRectangle(cornerRadius: 32)
                .fill(configuration.isOn ? Color.accent.primary : Color.background.secondary)
                .frame(width: 46, height: 24)
            
            Group {
                Circle()
                    .fill(configuration.isOn ? .white : Color.background.primary)
                    .frame(width: 18, height: 18)
            }
            .padding(3)
        }
        .padding(3)
        .onTapGesture {
            withAnimation {
                configuration.$isOn.wrappedValue.toggle()
            }
        }
    }
  }
}

#Preview {
    ContentView()
        .environmentObject(ContentView.ViewModel())
        .environmentObject(OnboardView.ViewModel(loginStepAction: {}))
        .environmentObject(BottomBar.ViewModel())
}

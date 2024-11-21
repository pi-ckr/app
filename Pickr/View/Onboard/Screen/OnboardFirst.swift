//
//  First.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/4/24.
//

import SwiftUI

struct OnboardFirst: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("내 맘대로 픽")
                        .typography(.heading, color: Color("System/White"))
                        .background(Color.accent.primary)
                    Text("해서")
                        .typography(.heading, color: .content.primary)
                }
                Text("공부하는 영단어")
                    .typography(.heading, color: .content.primary)
            }
            Text("모르는 단어가 생기셨나요? 단어를 픽 해보세요")
                .typography(.label, color: .content.secondary)
        }
    }
}

#Preview {
    OnboardFirst()
}

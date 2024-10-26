//
//  First.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/4/24.
//

import SwiftUI

struct OnboardThird: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(spacing: 0) {
                Text("언제나 함께하는")
                    .typography(.heading, color: .content.primary)
                HStack(spacing: 0) {
                    Text("인공지능 ")
                        .typography(.heading, color: Color("System/White"))
                        .background(Color.accent.primary)
                    Text("도우미")
                        .typography(.heading, color: .content.primary)
                }
            }
            Text("목표를 정하고 그 목표를 매일 매일 채워가보아요")
                .typography(.label, color: .content.secondary)
        }
    }
}

#Preview {
    OnboardThird()
}

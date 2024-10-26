//
//  First.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/4/24.
//

import SwiftUI

struct OnboardFirst: View {
    var body: some View {
        VStack {
            VStack(spacing: 24) {
                VStack(spacing: 30) {
                    Image("logo")
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Text("내 맘대로 픽")
                                .typography(.heading, color: .background.primary)
                                .background(
                                            GeometryReader { geometry in
                                                Rectangle()
                                                    .fill(Color.white)
                                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                            }
                                        )
                            Text("해서")
                                .typography(.heading, color: .content.primary)
                        }
                        Text("공부하는 영단어")
                            .typography(.heading, color: .content.primary)
                    }
                }
                VStack(spacing: 0) {
                    Text("웹 서핑 도중 모르는 단어가 생기셨나요?")
                        .typography(.label, color: .content.tertiary)
                    HStack(spacing: 0) {
                        Text("피커와 함께 ")
                            .typography(.label, color: .content.tertiary)
                        Text("단어를 픽 ")
                            .typography(.label, color: .accent.primary)
                        Text("해보세요")
                            .typography(.label, color: .content.tertiary)
                    }
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

#Preview {
    OnboardFirst()
}

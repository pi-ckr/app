//
//  First.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/4/24.
//

import SwiftUI

struct OnboardSecond: View {
    var body: some View {
        VStack {
            VStack(spacing: 24) {
                VStack(spacing: 30) {
                    Image("logo")
                    VStack(spacing: 0) {
                        Text("매일 매일 채워가는")
                            .typography(.heading, color: ColorPalette.Content.Primary)
                        HStack(spacing: 0) {
                            Text("나만의 ")
                                .typography(.heading, color: ColorPalette.Content.Primary)
                            Text("목표 공부량")
                                .typography(.heading, color: ColorPalette.Accent.Primary)
                        }
                    }
                }
                VStack(spacing: 0) {
                    Text("피커와 함께 목표를 정하고")
                        .typography(.label, color: ColorPalette.Content.Tertiary)
                    Text("그 목표를 매일 매일 채워가보아요")
                        .typography(.label, color: ColorPalette.Content.Tertiary)
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

#Preview {
    OnboardSecond()
}

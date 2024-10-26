//
//  First.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/4/24.
//

import SwiftUI

struct OnboardThird: View {
    var body: some View {
        VStack {
            VStack(spacing: 24) {
                VStack(spacing: 30) {
                    Image("logo")
                    VStack(spacing: 0) {
                        Text("언제나 함께하는")
                            .typography(.heading, color: ColorPalette.Content.Primary)
                        HStack(spacing: 0) {
                            Text("인공지능 ")
                                .typography(.heading, color: ColorPalette.Accent.Primary)
                            Text("도우미")
                                .typography(.heading, color: ColorPalette.Content.Primary)
                        }
                    }
                }
                VStack(spacing: 0) {
                    Text("피커 AI로 픽한 단어를")
                        .typography(.label, color: ColorPalette.Content.Tertiary)
                    Text("꾸준히 복습해보아요")
                        .typography(.label, color: ColorPalette.Content.Tertiary)
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

#Preview {
    OnboardThird()
}

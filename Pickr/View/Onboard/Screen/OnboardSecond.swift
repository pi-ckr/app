//
//  OnboardSecond.swift
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
                        Typography(text: "매일 매일 채워가는", color: ColorPalette.Content.Primary, fontType: .Heading)
                        HStack(spacing: 0) {
                            Typography(text: "나만의 ", color: ColorPalette.Content.Primary, fontType: .Heading)
                            Typography(text: "목표 공부량", color: ColorPalette.Accent.Primary, fontType: .Heading)
                        }
                    }
                }
                VStack(spacing: 0) {
                    Typography(text: "피커와 함께 목표를 정하고", color: ColorPalette.Content.Tertiary, fontType: .Label)
                    Typography(text: "그 목표를 매일 매일 채워가보아요", color: ColorPalette.Content.Tertiary, fontType: .Label)
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

#Preview {
    OnboardSecond()
}

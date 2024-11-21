//
//  Icon.swift
//  Pickr
//
//  Created by  jwkwon0817 on 11/11/24.
//

import SwiftUI

struct Icon: View {
   let name: String
   var size: CGFloat = 24 // 기본값 설정
   var color: Color = .black // 기본값 설정
   
   var body: some View {
       Image(name)
           .renderingMode(.template) // 색상 변경을 위해 템플릿 모드 사용
           .resizable() // 크기 조절을 위해 필요
           .aspectRatio(contentMode: .fit) // 비율 유지
           .frame(width: size, height: size) // 크기 지정
           .foregroundColor(color) // 색상 적용
   }
}

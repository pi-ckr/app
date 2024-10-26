//
//  OnboardLogin.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/4/24.
//

import SwiftUI

struct OnboardLogin: View {
    @State var id: String = ""
    @State var password: String = ""
    @State private var keyboardHeight: CGFloat = 0
    @State private var isKeyboardVisible: Bool = false // 키보드 상태를 추적

    var body: some View {
        VStack {
            VStack(spacing: 86) {
                if !isKeyboardVisible { // 키보드가 보일 때 로고 숨기기
                    VStack(spacing: 20) {
                        Image("logo_long")
                        Text("내 맘대로 픽해서 공부하는 영단어")
                            .typography(.headline, color: ColorPalette.Content.Secondary)
                    }
                }
                
                VStack(spacing: 20) {
                    LoginInput(label: "아이디", text: id, placeholder: "아이디를 입력해주세요.")
                    LoginInput(label: "비밀번호", text: password, placeholder: "비밀번호를 입력해주세요.", isPassword: true)
                }
            }
            .padding(.bottom, keyboardHeight) // 키보드 높이에 따라 패딩을 추가
            .onAppear {
                withAnimation {
                    // 키보드 이벤트를 감지하여 높이를 조절
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                            if keyboardFrame.height > 300 {
                                self.keyboardHeight = keyboardFrame.height
                            }
                        }
                    }
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                        self.keyboardHeight = 0
                    }
                }
            }
            .onDisappear {
                withAnimation {
                    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
                    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.bottom) // 키보드에 의해 잘리는 것을 방지
        .contentShape(Rectangle())
        .onTapGesture {
            hideKeyboard() // 화면을 터치하면 키보드를 숨김
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct LoginInput: View {
    let label: String
    @State var text: String
    let placeholder: String
    @FocusState private var isFocused: Bool
    var isPassword: Bool = false
    
    @State var isOpened: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .typography(.labelEmphasized, color: ColorPalette.Content.Primary)
            
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .typography(.label, color: ColorPalette.Content.Invert)
                        .padding(14)
                }

                ZStack(alignment: .trailing) {
                    if isPassword {
                        if isOpened {
                            TextField("", text: $text) // 일반 텍스트 필드
                                .padding(14)
                                .padding(.trailing, 34)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(isFocused ? ColorPalette.Accent.Primary : Color.clear, lineWidth: 1.5)
                                        .animation(.easeInOut(duration: 0.2), value: isFocused))
                                .focused($isFocused)
                                .typography(.label, color: ColorPalette.Content.Primary)
                        } else {
                            SecureField("", text: $text)
                                .padding(14)
                                .padding(.trailing, 34)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(isFocused ? ColorPalette.Accent.Primary : Color.clear, lineWidth: 1.5)
                                        .animation(.easeInOut(duration: 0.2), value: isFocused))
                                .focused($isFocused)
                                .typography(.label, color: ColorPalette.Content.Primary)
                        }

                        // 눈 아이콘
                        Image(isOpened ? "Eye/Opened" : "Eye/Closed")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(ColorPalette.Content.Invert)
                            .onTapGesture {
                                withAnimation {
                                    isOpened.toggle()
                                }
                            }
                            .padding(.trailing, 14)
                    } else {
                        TextField("", text: $text) // 일반 텍스트 필드 (비밀번호가 아닌 경우)
                            .padding(14)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(isFocused ? ColorPalette.Accent.Primary : Color.clear, lineWidth: 1.5)
                                    .animation(.easeInOut(duration: 0.2), value: isFocused))
                            .focused($isFocused)
                            .typography(.label, color: ColorPalette.Content.Primary)
                    }
                }
            }
        }
    }
}


#Preview {
    OnboardView()
}

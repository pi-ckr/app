//
//  HomeScreen.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/27/24.
//

import SwiftUI

struct ProfileScreen: View {
    @State var showDetail: Bool = false
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var wordViewModel: WordViewModel
    
    var body: some View {
        ScreenTemplate(titleBar: {
            TitleBar(title: "내 정보", icon: {
                Icon(name: "Icon/discover_tune", color: .content.primary)
            }, action: {
                showDetail = true
            })
        }) { 
            VStack(spacing: 4) {
                VStack {
                    HStack(spacing: 20) {
                        Image("Profile/\(authViewModel.me?.profilePicture ?? "0")")
                            .resizable()
                            .frame(width: 72, height: 72)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("레벨 3")
                                .typography(.body, color: .accent.primary)
                            
                            Text(authViewModel.me?.username ?? "사용자 이름 없음")
                                .typography(.titleEmphasized, color: .content.primary)
                            
                            Button(action: {}) {
                                Text("내 정보 수정...")
                                    .typography(.body, color: .content.secondary)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.vertical, 30)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("내 뱃지")
                        .typography(.headlineEmphasized, color: .content.primary)
                        
                    VStack(spacing: 6) {
                        ForEach(wordViewModel.badges.indices, id: \.self) { index in
                            let badge = wordViewModel.badges[index]
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text("\(badge.badgeName) [\(badge.description)]")
                                    .typography(.label, color: Color.content.primary)
                            
                                HStack(spacing: 6) {
                                    if let rate = Int(badge.rate) {
                                        if rate >= 1 {
                                            Group {
                                                Image("Badge/bronze")
                                            }
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 110)
                                            .background(Color.border.primary)
                                        } else {
                                            Group {
                                                Image("Badge/bronze")
                                                    .renderingMode(.template)
                                                    .foregroundStyle(.clear)
                                            }
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 110)
                                            .background(Color.border.primary)
                                        }
                                        
                                        if rate >= 2 {
                                            Group {
                                                Image("Badge/silver")
                                            }
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 110)
                                            .background(Color.border.primary)
                                        } else {
                                            Group {
                                                Image("Badge/silver")
                                                    .renderingMode(.template)
                                                    .foregroundStyle(.clear)
                                            }
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 110)
                                            .background(Color.border.primary)
                                        }
                                        
                                        if rate >= 3 {
                                            Group {
                                                Image("Badge/gold")
                                            }
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 110)
                                            .background(Color.border.primary)
                                        } else {
                                            Group {
                                                Image("Badge/gold")
                                                    .renderingMode(.template)
                                                    .foregroundStyle(.clear)
                                            }
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 110)
                                            .background(Color.border.primary)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading) 
                .padding(.horizontal, 20)
                .padding(.vertical, 24)
                .padding(.bottom, 100)
                .background(Color.background.secondary)
            }
        }
        .detailNavigation(isPresented: $showDetail) {
            ProfileDetailScreen(showDetail: $showDetail)
        }
    }
}

struct ProfileDetailScreen: View {
    @Binding var showDetail: Bool
    
    @State var isOnDarkmode: Bool = false
    
    @State var showAlert: Bool = false
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ScreenTemplate(titleBar: {
            TitleBar(title: "설정", leftIcon: {
                Icon(name: "Icon/arrow_back", color: .content.primary)
            }, leftAction: {
                showDetail = false
            })
        }) {
            VStack(alignment: .leading, spacing: 0) {
                Text("일반")
                    .typography(.labelEmphasized, color: Color.content.primary)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                
                HStack {
                    Button(action: {
                        showAlert = true
                    }) {
                        Text("로그아웃")
                            .typography(.labelEmphasized, color: Color.status.danger)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color.background.secondary)
                            .cornerRadius(4)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                               title: Text("로그아웃"),
                               message: Text("정말 로그아웃 하시겠습니까?"),
                               primaryButton: .destructive(Text("로그아웃")) {
                                   Task {
                                       authViewModel.logout()
                                   }
                               },
                               secondaryButton: .cancel(Text("취소"))
                           )
                    }
//                    Toggle(isOn: $isOnDarkmode) {
//                        VStack(alignment: .leading, spacing: 4) {
//                            Text("다크모드 사용")
//                                .typography(.labelEmphasized, color: Color.content.primary)
//                            Text("다크모드를 통해 시각적 피로도를 줄입니다.")
//                                .typography(.body, color: Color.content.secondary)
//                        }
//                    }
//                    .toggleStyle(CustomToggleStyle())
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ContentView.ViewModel())
        .environmentObject(OnboardView.ViewModel(loginStepAction: {}))
        .environmentObject(BottomBar.ViewModel())
        .environmentObject(WordViewModel())
        .environmentObject(AuthViewModel())
}


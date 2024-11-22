//
//  OnboardLoginVerificationCodePage 2.swift
//  Pickr
//
//  Created by  jwkwon0817 on 11/22/24.
//


//
//  OnboardLoginVerificationCodePage.swift
//  Pickr
//
//  Created by  jwkwon0817 on 11/22/24.
//

import SwiftUI

struct OnboardSignupImagePage: View {
    
    @Binding var selection: Int
    @Binding var username: String
    @Binding var password: String
    @Binding var birth: String
    @Binding var gender: String
    @Binding var phoneNumber: String
    @Binding var profileImage: String
    @Binding var accessKey: String
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(.clear)
                .frame(height: 78)
            VStack(alignment: .leading, spacing: 31) {
                Text("앱에서 사용할 프로필 사진을\n선택해주세요")
                    .typography(.largeTitle, color: Color.content.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                VStack(spacing: 20) {
                    HStack {
                        ProfileImageButton(
                            imageNumber: "0",
                            isSelected: profileImage == "0"
                        ) {
                            profileImage = "0"
                        }
                        
                        Spacer()
                        
                        ProfileImageButton(
                            imageNumber: "1",
                            isSelected: profileImage == "1"
                        ) {
                            profileImage = "1"
                        }
                        
                        Spacer()
                        
                        ProfileImageButton(
                            imageNumber: "2",
                            isSelected: profileImage == "2"
                        ) {
                            profileImage = "2"
                        }
                    }
                    
                    HStack {
                        ProfileImageButton(
                            imageNumber: "3",
                            isSelected: profileImage == "3"
                        ) {
                            profileImage = "3"
                        }
                        
                        Spacer()
                        
                        ProfileImageButton(
                            imageNumber: "4",
                            isSelected: profileImage == "4"
                        ) {
                            profileImage = "4"
                        }
                        
                        Spacer() 
                        
                        ProfileImageButton(
                            imageNumber: "5",
                            isSelected: profileImage == "5"
                        ) {
                            profileImage = "5"
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Button(action: {
                    Task {
                        authViewModel.signup(username: username, password: password, phoneNumber: phoneNumber, accessKey: accessKey, profilePicture: profileImage, birthday: formatBirthDate(birthFirst: birth, birthLast: gender))
                    }
                }) {
                    Image("Icon/arrow_forward")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.white)
                        .frame(width: 54, height: 54)
                        .background(profileImage.isEmpty ? Color.fill.primary : Color.accent.primary)
                        .cornerRadius(2)
                }
                .disabled(profileImage.isEmpty)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 40)
            .padding(.bottom, 39)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.primary)
    }
}

struct ProfileImageButton: View {
    let imageNumber: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Image("Profile/\(imageNumber)")
                    .clipShape(Circle())
               
                if isSelected {
                    Circle()
                        .fill(.black.opacity(0.3))
                        .frame(width: 100, height: 100)
                   
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                }
            }
        }
    }
}

func formatBirthDate(birthFirst: String, birthLast: String) -> String {
   guard birthFirst.count == 6 else { return "" }
   
   // 앞자리가 0이면 2000년대, 아니면 1900년대
   let year = birthLast == "3" || birthLast == "4" ? "19" : "20"
   let fullYear = year + birthFirst.prefix(2)
   let month = birthFirst.dropFirst(2).prefix(2)
   let day = birthFirst.dropFirst(4).prefix(2)
   
   return "\(fullYear)-\(month)-\(day)"
}

#Preview {
    OnboardSignupPasswordPage(selection: .constant(2), password: .constant(""))
        .environmentObject(AuthViewModel())
}

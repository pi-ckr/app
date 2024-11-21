//
//  AuthViewModel.swift
//  Pickr
//
//  Created by  jwkwon0817 on 11/11/24.
//
import SwiftUI
import Alamofire

extension Notification.Name {
    static let userDidAuthenticate = Notification.Name("userDidAuthenticate")
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false {
        didSet {
            if isAuthenticated {
                NotificationCenter.default.post(name: .userDidAuthenticate, object: nil)
            }
        }
    }
    @Published var error: Error?
    @Published var isLoading = false
    
    @Published var me: MeResponse? = nil
    
    init() {
//        checkAuthentication()
        
    }
    
    private func checkAuthentication() {
        Task {
            isLoading = true  // 체크 시작 전 로딩 상태 true
            do {
                let _: EmptyResponse = try await APIClient.shared.request("/api/users", authRequired: true)
                isAuthenticated = true
            } catch {
                if let afError = error as? AFError,
                   let statusCode = afError.responseCode,
                   statusCode == 401 {
                    isAuthenticated = false
                }
            }
            isLoading = false  // 체크 완료 후 로딩 상태 false
        }
    }
    
    func login(username: String, password: String) {
        isLoading = true
        
        Task {
            do {
                let response = try await AuthService.login(username: username, password: password)
                // 토큰 저장
                if KeychainHelper.update(token: response.accessToken, forAccount: "accessToken") {
                    isAuthenticated = true
                    
                }
                
                me = try await AuthService.me()
            } catch {
                self.error = error
                print(error.localizedDescription)
            }
            
            isLoading = false
        }
    }
    
    func logout() {
        KeychainHelper.delete(forAccount: "accessToken")
        isAuthenticated = false
    }
}

struct EmptyResponse: Codable {}

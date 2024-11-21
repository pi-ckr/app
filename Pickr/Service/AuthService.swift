//
//  AuthServiceProtocol.swift
//  Pickr
//
//  Created by  jwkwon0817 on 11/11/24.
//
import Foundation
import Alamofire


protocol AuthServiceProtocol {
    static func login(username: String, password: String) async throws -> LoginResponse
    
    static func me() async throws -> MeResponse
}


class AuthService: AuthServiceProtocol {
    static func login(username: String, password: String) async throws -> LoginResponse {
        return try await APIClient.shared.request("/api/users/login", method: .post, parameters: [
            "username": username,
            "password": password
        ], form: true)
    }
    
    static func me() async throws -> MeResponse {
        return try await APIClient.shared.request("/api/users/", authRequired: true)
    }
}

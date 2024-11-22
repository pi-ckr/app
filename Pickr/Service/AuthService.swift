//
//  AuthServiceProtocol.swift
//  Pickr
//
//  Created by  jwkwon0817 on 11/11/24.
//
import Foundation
import Alamofire


protocol AuthServiceProtocol {
    static func login(username: String, password: String, phoneNumber: String, accessKey: String) async throws -> LoginResponse
    
    static func signup(username: String, password: String, phoneNumber: String, accessKey: String, profilePicture: String, birthday: String) async throws -> LoginResponse
    
    static func me() async throws -> MeResponse
    
    static func smsVerifiy(_ phoneNumber: String) async throws -> SmsResponse
    
    static func smsConfirm(_ phoneNumber: String, code: String) async throws -> SmsConfirmResponse
}


class AuthService: AuthServiceProtocol {
    static func login(username: String, password: String, phoneNumber: String, accessKey: String) async throws -> LoginResponse {
        return try await APIClient.shared.request("/api/users/login", method: .post, parameters: [
            "username": username,
            "password": password,
            "phone_number": phoneNumber,
            "access_key": accessKey
        ])
    }
    
    static func signup(username: String, password: String, phoneNumber: String, accessKey: String, profilePicture: String, birthday: String) async throws -> LoginResponse {
        return try await APIClient.shared.request("/api/users/signup", method: .post, parameters: [
            "username": username,
            "password": password,
            "phone_number": phoneNumber,
            "access_key": accessKey,
            "profile_picture": profilePicture,
            "birthday": birthday
        ])
    }
    
    static func me() async throws -> MeResponse {
        return try await APIClient.shared.request("/api/users/", authRequired: true)
    }
    
    static func smsVerifiy(_ phoneNumber: String) async throws -> SmsResponse {
        return try await APIClient.shared.request("/api/sms/", method: .post, parameters: [
            "phone_number": phoneNumber
        ])
    }
    
    static func smsConfirm(_ phoneNumber: String, code: String) async throws -> SmsConfirmResponse {
        return try await APIClient.shared.request("/api/sms/cornfirm", method: .post, parameters: [
            "phone_number": phoneNumber,
            "code": code
        ])
    }
}

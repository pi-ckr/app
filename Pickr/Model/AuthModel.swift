//
//  AuthModel.swift
//  Pickr
//
//  Created by  jwkwon0817 on 11/11/24.
//
struct LoginResponse: Decodable {
    let accessToken: String
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
}

struct Badge: Codable {
    let id: Int
    let name: String
    let description: String
}

struct MeResponse: Decodable {
    let id: Int
    let username: String
    let profilePicture: String
    let birthday: String
    let phoneNumber: String
    let selectedWords: [Word]
    let favoriteWords: [Word]
    let badges: [Badge]
    let grass: [[Int]]
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case profilePicture = "profile_picture"
        case birthday
        case phoneNumber = "phone_number"
        case selectedWords = "selected_words"
        case favoriteWords = "favorite_words"
        case badges
        case grass
    }
}

struct SmsResponse: Decodable {
    let successCount: Int
    let errorCount: Int
    let groupId: String
    
    enum CodingKeys: String, CodingKey {
        case successCount = "success_count"
        case errorCount = "error_count"
        case groupId = "group_id"
    }
}

struct SmsConfirmResponse: Decodable {
    let accessKey: String
    
    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
    }
}

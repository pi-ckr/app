//
//  AuthServiceProtocol.swift
//  Pickr
//
//  Created by  jwkwon0817 on 11/11/24.
//
import Foundation
import Alamofire


protocol WordServiceProtocol {
    static func getWordList() async throws -> [Word]
    static func getVocabularyList() async throws -> [Vocabulary]
    static func getFavoriteVocabularyList() async throws -> [Vocabulary]
    static func changeFavoriteVocabulary(_ vocaName: String, favorite: Bool) async throws -> SuccessFavoriteVocabularyResult
    static func getMemorizeWordQuiz(_ vocaName: String) async throws -> [Quiz]
    static func getExampleSentenceQuiz(_ vocaName: String) async throws -> [SentenceQuiz]
    static func submitMemorizeWordQuizResult(_ vocaName: String, incorrect: [String]) async throws -> SuccessResult
    static func submitExampleSentenceQuizResult(_ vocaName: String, incorrect: [String]) async throws -> SuccessResult
    static func search(_ word: String) async throws -> Word
    static func createVocabulary(_ vocaName: String, words: [String]) async throws -> CreateVocabulary
    static func deleteVocabulary(_ vocaName: String) async throws -> SuccessResult
    static func getHistory(_ date: String) async throws -> HistoryResponse
}

// Services/AuthService.swift
class WordService: WordServiceProtocol {
    static func getWordList() async throws -> [Word] {
        return try await APIClient.shared.request("/api/words/users", authRequired: true)
    }
    
    static func getVocabularyList() async throws -> [Vocabulary] {
        return try await APIClient.shared.request("/api/vocabulary/", authRequired: true)
    }
    
    static func getFavoriteVocabularyList() async throws -> [Vocabulary] {
        return try await APIClient.shared.request("/api/vocabulary/favorite", authRequired: true)
    }
    
    static func changeFavoriteVocabulary(_ vocaName: String, favorite: Bool) async throws -> SuccessFavoriteVocabularyResult {
        return try await APIClient.shared.request("/api/vocabulary/favorite?vocabulary_list=\(vocaName)&isfavorite=\(favorite)", method: .post, authRequired: true)
    }
    
    static func getMemorizeWordQuiz(_ vocaName: String) async throws -> [Quiz] {
        return try await APIClient.shared.request("/api/quiz/quiz?list_name=\(vocaName)", authRequired: true)
    }
    
    static func getWrongWordQuiz(incorrect: [String]) async throws -> [Quiz] {
        return try await APIClient.shared.request("/api/quiz/quiz/wrong?words=\(incorrect.joined(separator: ","))", authRequired: true)
    }
    
    static func getExampleSentenceQuiz(_ vocaName: String) async throws -> [SentenceQuiz] {
        return try await APIClient.shared.request("/api/sentence/?vocab_list=\(vocaName)", authRequired: true)
    }
    
    static func submitMemorizeWordQuizResult(_ vocaName: String, incorrect: [String]) async throws -> SuccessResult {
        let parameters: [String: Any] = [
            "list_name": vocaName,
            "incorrect": incorrect
        ]
        
        return try await APIClient.shared.request("/api/quiz/quiz", method: .post, parameters: parameters, authRequired: true)
    }
    
    static func submitWrongWordQuizResult(incorrect: [String]) async throws -> SuccessResult {
        let parameters: [String: Any] = [
            "words": incorrect
        ]
        
        return try await APIClient.shared.request("/api/quiz/quiz/wrong", method: .post, parameters: parameters, authRequired: true)
    }
    
    static func submitExampleSentenceQuizResult(_ vocaName: String, incorrect: [String]) async throws -> SuccessResult {
        let parameters: [String: Any] = [
            "list_name": vocaName,
            "incorrect": incorrect
        ]
        
        return try await APIClient.shared.request("/api/sentence/", method: .post, parameters: parameters, authRequired: true)
    }
    
    static func search(_ word: String) async throws -> Word {
        return try await APIClient.shared.request("/api/words/search?word=\(word)")
    }
    
    static func createVocabulary(_ vocaName: String, words: [String]) async throws -> CreateVocabulary {
        let parameters: [String: Any] = [
            "name": vocaName,
            "words": words
        ]
        
        return try await APIClient.shared.request("/api/vocabulary/", method: .post, parameters: parameters, authRequired: true)
    }
    
    static func deleteVocabulary(_ vocaName: String) async throws -> SuccessResult {
        return try await APIClient.shared.request("/api/vocabulary/?vocabulary_list=\(vocaName)", method: .delete, authRequired: true)
    }
    
    static func getHistory(_ date: String) async throws -> HistoryResponse {
        return try await APIClient.shared.request("/api/history/routines?routine_date=\(date)", authRequired: true) 
    }
    
    
}

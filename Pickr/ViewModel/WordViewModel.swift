//
//  AuthViewModel.swift
//  Pickr
//
//  Created by  jwkwon0817 on 11/11/24.
//
import SwiftUI


@MainActor
class WordViewModel: ObservableObject {
    @Published var wordList: [Word] = []
    @Published var vocabularyList: [Vocabulary] = []
    @Published var favoriteVocabularyList: [Vocabulary] = []
    @Published var selectedStudyVocabulary: Vocabulary? = nil
    @Published var history: HistoryResponse? = nil
    
    @Published var error: Error?
    @Published var isLoading = false
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleAuthentication), name: .userDidAuthenticate, object: nil)
    }

    func fetchWords() {
        isLoading = true 
        Task {
            do {
                let result = try await WordService.getWordList()
                wordList = result
            } catch {
                self.error = error
            }
            isLoading = false
        }
    }
    
    func fetchVocabularyList() {
        isLoading = true
        Task {
            do {
                let result = try await WordService.getVocabularyList()
                let favoriteResult = try await WordService.getFavoriteVocabularyList()
                
                vocabularyList = result
                favoriteVocabularyList = favoriteResult
            } catch {
                self.error = error
            }
            isLoading = false
        }
    }
    
    func fetchHistory(_ date: String) {
        isLoading = true
        Task {
            do {
                let result = try await WordService.getHistory(date) 
                 
                history = result
            } catch {
                self.error = error
            }
            isLoading = false
        }
    }
    
    @objc private func handleAuthentication() {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayString = dateFormatter.string(from: Date())
        
        fetchWords()
        fetchVocabularyList()
        fetchHistory(todayString)
    }
}

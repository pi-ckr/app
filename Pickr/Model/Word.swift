struct Word: Identifiable, Codable {
    var id: Int = 0
    let word: String
    let meanings: [String]
    let sampleSentence: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case word
        case meanings 
        case sampleSentence = "sample_sentence"
    }
}

struct Vocabulary: Identifiable, Codable {
    var id: Int = 0
    let name: String
    let words: [Word]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case words
    }
}

struct Quiz: Codable {
    let word: String
    let meaning: String
    let options: [String]
    
    enum CodingKeys: String, CodingKey {
        case word
        case meaning
        case options
    }
}

struct SuccessResult: Codable {
    let message: String
}

struct SuccessFavoriteVocabularyResult: Identifiable, Codable {
    var id: Int = 0
    let name: String
    let isFavorite: Bool
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case isFavorite = "is_favorite"
    }
}

struct CreateVocabulary: Identifiable, Codable {
    var id: Int = 0
    let name: String
    let words: [Word]
}

struct HistoryResponse: Codable {
    let id: Int
    let userId: Int
    let date: String
    let correctRate: Double
    let incorrectRate: Double
    let mistakeWords: [Word]
    let memorizeWords: [MemorizeWordStruct]
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case date
        case correctRate = "correct_rate"
        case incorrectRate = "incorrect_rate"
        case mistakeWords = "mistake_words"
        case memorizeWords = "memorize_words"
    }
}


struct MemorizeWordStruct: Codable {
    let id: Int
    let userId: Int
    let vocabularyList: String
    let correctRate: Double
    let memorizedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case vocabularyList = "vocabulary_list"
        case correctRate = "correct_rate"
        case memorizedAt = "memorized_at"
    }
}

struct SentenceQuiz: Codable {
    let word: String
    let meanings: [String]
    let translated: String
    let quizSentence: String
    
    enum CodingKeys: String, CodingKey {
        case word
        case meanings
        case translated
        case quizSentence = "Quiz_sentence"
    }
}

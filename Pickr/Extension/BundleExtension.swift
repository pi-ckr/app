import Foundation

enum ConfigurationError: Error {
    case missingKey(String)
}

extension Bundle {
    // 일반적인 설정값을 가져오는 메서드
    func configuration(for key: String) -> String? {
        object(forInfoDictionaryKey: key) as? String
    }
    
    // 필수 설정값을 가져오는 메서드 (없으면 에러)
    func requiredConfiguration(for key: String) throws -> String {
        guard let value = configuration(for: key) else {
            throw ConfigurationError.missingKey(key)
        }
        return value
    }
}

// 구체적인 설정 키들을 enum으로 관리
enum ConfigurationKey {
//    static let apiKey = "API_KEY"
    static let baseURL = "BASE_URL"
//    static let clientId = "CLIENT_ID"
}

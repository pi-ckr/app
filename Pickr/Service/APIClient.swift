import Foundation
import Alamofire

class APIClient {
    static let shared = APIClient()
    
    func request<T: Decodable>(_ endpoint: String, method: HTTPMethod = .get, parameters: [String: Any]? = nil, authRequired: Bool = false, form: Bool = false) async throws -> T {
        let urlString = "\(Network.baseUrl)\(endpoint)"
        
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: -1, userInfo: nil)
        }
        
        // JSON 인코딩으로 변경
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url,
                       method: method,
                       parameters: parameters,
                       encoding: form ? URLEncoding.default : JSONEncoding.default,  // URLEncoding을 JSONEncoding으로 변경
                       headers: [
                        "Content-Type": form ? "application/x-www-form-urlencoded" : "application/json",
                        "Accept": "application/json",
                        "Bearer": authRequired ? "\(KeychainHelper.read(forAccount: "accessToken") ?? "")" : ""
                       ])
            .validate() // 응답 상태 코드 검증 추가
            .responseDecodable(of: T.self) { response in
                debugPrint(response)
                
                switch response.result { 
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    print("Error: \(error)")
                    // 서버 에러 메시지가 있다면 출력
                    if let data = response.data {
                        print("Server response: \(String(data: data, encoding: .utf8) ?? "nil")")
                    }
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

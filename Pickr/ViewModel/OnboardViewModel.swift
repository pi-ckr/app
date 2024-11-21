import SwiftUI

extension OnboardView {
    class ViewModel: ObservableObject {
        @Published var step: OnboardStep = .first
        
        private let loginStepAction: () -> Void
            
        init(loginStepAction: @escaping () -> Void) {
            self.loginStepAction = loginStepAction
        }
        
        func moveToNextStep() {
            withAnimation {
                switch step {
                case .first:
                    step = .second
                case .second:
                    step = .third
                case .third:
                    loginStepAction()
                case .login:
                    loginStepAction()
                }
            }
        }
        
        func getOrder() -> Int {
            let dict: [OnboardStep: Int] = [.first: 1, .second: 2, .third: 3, .login: 4]
            return dict[step] ?? 1
        }
    }
}

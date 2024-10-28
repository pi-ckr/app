import SwiftUI

extension OnboardView {
    class ViewModel: ObservableObject {
        @Published var step: OnboardStep = .first
        
        private let thirdStepAction: () -> Void
            
        init(thirdStepAction: @escaping () -> Void) {
            self.thirdStepAction = thirdStepAction
        }
        
        func moveToNextStep() {
            withAnimation {
                switch step {
                case .first:
                    step = .second
                case .second:
                    step = .third
                case .third:
                    thirdStepAction()
                }
            }
        }
        
        func getOrder() -> Int {
            let dict: [OnboardStep: Int] = [.first: 1, .second: 2, .third: 3]
            return dict[step] ?? 1
        }
    }
}

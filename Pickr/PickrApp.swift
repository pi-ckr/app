import SwiftUI
import Alamofire

@main
struct PickrApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(BottomBar.ViewModel())
                .environmentObject(ContentView.ViewModel())
                .environmentObject(OnboardView.ViewModel(loginStepAction: {}))
                .environmentObject(AuthViewModel())
                .environmentObject(WordViewModel())
        }
    }
}

//struct LaunchScreenView: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> some UIViewController {
//        let controller = UIStoryboard(name: "Launch Screen", bundle: nil).instantiateInitialViewController()!
//        return controller
//    }
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//    }
//}

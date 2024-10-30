import SwiftUI

@main
struct PickrApp: App {
    init() {
        Thread.sleep(forTimeInterval: 1)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(BottomBar.ViewModel())
                .environmentObject(ContentView.ViewModel())
                .environmentObject(OnboardView.ViewModel(thirdStepAction: {}))
                .environmentObject(BottomSheetViewModel())
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

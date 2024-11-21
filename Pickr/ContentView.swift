import SwiftUI
import Lottie

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject var bottomBarViewModel: BottomBar.ViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
   
    func currentTab() -> any View {
        switch (bottomBarViewModel.selectedTab) {
        case .home:
            return HomeScreen()
        case .vocabulary:
            return VocabularyScreen()
        case .study:
            return StudyScreen()
        case .history:
            return HistoryScreen()
        case .profile:
            return ProfileScreen()
        }
    }
    
    @State var isShowingSplash: Bool = true
    
    var body: some View {
        if isShowingSplash {
            LottieView(animation: .named("pickr"))
                .playing()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        isShowingSplash = false
                    } 
                }
        } else {
            if viewModel.isShowingOnboard {
                OnboardView(loginStepAction: {
                    viewModel.hideOnboard()
                }).environmentObject(viewModel)
            } else {
                if authViewModel.isAuthenticated {
                    ZStack {
                        AnyView(currentTab())
                        
                        VStack {
                            Spacer()
                            BottomBar()
                        }
                    }
                } else {
                    OnboardView(loginStepAction: {
                        viewModel.hideOnboard()
                    }).environmentObject(viewModel)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ContentView.ViewModel())
        .environmentObject(OnboardView.ViewModel(loginStepAction: {}))
        .environmentObject(BottomBar.ViewModel())
        .environmentObject(AuthViewModel())
        .environmentObject(WordViewModel())
}

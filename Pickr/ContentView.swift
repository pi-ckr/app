import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject var bottomBarViewModel: BottomBar.ViewModel
   
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
    
    var body: some View {
        if viewModel.isShowingOnboard {
            OnboardView(thirdStepAction: {
                viewModel.hideOnboard()
            }).environmentObject(viewModel)
        } else {
            ZStack {
                AnyView(currentTab())
                
                VStack {
                    Spacer()
                    BottomBar()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ContentView.ViewModel())
        .environmentObject(OnboardView.ViewModel(thirdStepAction: {}))
        .environmentObject(BottomBar.ViewModel())
}

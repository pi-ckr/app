import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject var bottomBarViewModel: BottomBar.ViewModel
    @EnvironmentObject var bottomSheetViewModel: BottomSheetViewModel
    
    var body: some View {
        if viewModel.isShowingOnboard {
            OnboardView(thirdStepAction: {
                viewModel.hideOnboard()
            }).environmentObject(viewModel)
        } else {
                TabView(selection: $bottomBarViewModel.selectedTab.animation(.none)) {
                    Group {
                        HomeScreen()
                            .tag(Tab.home)
                        
                        VocabularyScreen()
                            .tag(Tab.vocabulary)
                        
                        StudyScreen()
                            .tag(Tab.study)
                        
                        HistoryScreen()
                            .tag(Tab.history)
                        
                        ProfileScreen()
                            .tag(Tab.profile)
                    }
                }
                
                .toolbar(.hidden, for: .tabBar)
                .animation(nil, value:  bottomBarViewModel.selectedTab)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .ignoresSafeArea(.all)
                .hasBottomBar()
                .bottomSheet(isShowing: $bottomSheetViewModel.studySheet) {
                    StudyBottomSheet() 
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ContentView.ViewModel())
        .environmentObject(OnboardView.ViewModel(thirdStepAction: {}))
        .environmentObject(BottomBar.ViewModel())
        .environmentObject(BottomSheetViewModel())
}

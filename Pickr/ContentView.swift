import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject var bottomBarViewModel: BottomBar.ViewModel
    
    var body: some View {
        if viewModel.isShowingOnboard {
            OnboardView(thirdStepAction: {
                viewModel.hideOnboard()
            }).environmentObject(viewModel)
        } else {
            ZStack {
                // 현재 선택된 탭에 따른 화면 표시
                
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
                .animation(nil, value: bottomBarViewModel.selectedTab)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                VStack {
                    Spacer()
                    BottomBar()
                }
            }
            .ignoresSafeArea(.all, edges: .top)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ContentView.ViewModel())
        .environmentObject(OnboardView.ViewModel(thirdStepAction: {}))
        .environmentObject(BottomBar.ViewModel())
}

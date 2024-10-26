import SwiftUI

struct ContentView: View {
    @StateObject var mainViewModel: MainViewModel = .init()
    @StateObject var bottomBarViewModel = BottomBarViewModel()
    
    var body: some View {
        if mainViewModel.isShowingOnboard {
            OnboardView(mainViewModel: mainViewModel)
        } else {
            ZStack(alignment: .bottom) {
                // 현재 선택된 탭에 따른 화면 표시
                
                TabView(selection: $bottomBarViewModel.selectedTab) {
                    HomeScreen()
                        .tag(BottomBarViewModel.Tab.home)
                        .tabItem {
                            EmptyView()
                        }
                    
                    VocabularyScreen()
                        .tag(BottomBarViewModel.Tab.vocabulary)
                        .tabItem {
                            EmptyView()
                        }
                    
                    StudyScreen()
                        .tag(BottomBarViewModel.Tab.study)
                        .tabItem {
                            EmptyView()
                        }
                    
                    HistoryScreen()
                        .tag(BottomBarViewModel.Tab.history)
                        .tabItem {
                            EmptyView()
                        }
                    
                    ProfileScreen()
                        .tag(BottomBarViewModel.Tab.profile)
                        .tabItem {
                            EmptyView()
                        }
                }
                .animation(.smooth(duration: 0.3), value: bottomBarViewModel.selectedTab)
                
                BottomBar(viewModel: bottomBarViewModel)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    ContentView()
}

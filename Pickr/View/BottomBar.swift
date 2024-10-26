import SwiftUI

struct BottomBar: View {
    @StateObject private var viewModel = BottomBarViewModel()
    
    var body: some View {
        ZStack {
            Image("test")
                .resizable()
                .frame(width: 358, height: 102)

            HStack(spacing: 0) {
                ForEach(viewModel.tabs, id: \.self) { tab in
                    VStack(spacing: 6) {
                        Rectangle()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 2)
                            .foregroundColor(.clear)
                        VStack(spacing: 2) {
                            Image(tab == viewModel.selectedTab ? "\(tab.iconName)_filled" : tab.iconName)
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(tab == viewModel.selectedTab ? .accent.primary : .content.secondary)
                            Text(tab.title)
                                .typography(tab == viewModel.selectedTab ? .footnoteEmphasized : .footnote, color: tab == viewModel.selectedTab ? .accent.primary : .content.secondary)
                        }
                        
                        .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .padding(.horizontal, 15)
                    .padding(.top, 0)
                    .padding(.bottom, 8)
                    .gesture(TapGesture().onEnded {
                        if tab != viewModel.selectedTab {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                viewModel.selectedTab = tab
                            }
                        }
                    })
                }
            }
            .background(
                GeometryReader { geometry in
                    let tabWidth = geometry.size.width / CGFloat(viewModel.tabs.count)
                    let indicatorWidth = tabWidth - 30
                    
                    let index = CGFloat(viewModel.tabs.firstIndex(of: viewModel.selectedTab) ?? 0)
                    
                    let centerX = tabWidth * index + 15
                    
                    Rectangle()
                        .frame(width: indicatorWidth, height: 2)
                        .foregroundColor(.accent.primary)
                        .cornerRadius(3)
                        .offset(x: centerX)
                        .animation(.easeInOut(duration: 0.3), value: viewModel.selectedTab)
                }
                , alignment: .top
            )
            .frame(minWidth: 0, maxWidth: .infinity)
            .background {
                TransparentBlurView(removeAllFilters: true)
                    .blur(radius: 24, opaque: true)
                    .background(Color.etc.bottomNavigationBar)
            }
            .shadow(
                color: Color.etc.bottomNavigationBarShadow,
                radius: 10,
                x: 0,
                y: -4
            )
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

#Preview {
    BottomBar()
}

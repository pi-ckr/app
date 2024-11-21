import SwiftUI

struct DetailNavigationModifier<DetailContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let detailContent: () -> DetailContent
    
    @State private var offset: CGFloat = 0
    @State private var detailOffset: CGFloat = UIScreen.main.bounds.width
    
    func body(content: Content) -> some View {
        content
            .offset(x: offset)
        
        // Detail View Container
        ZStack {
            if isPresented {
                GeometryReader { proxy in
                    return detailContent()
                        .zIndex(.infinity)
                }
            }
        }
        .offset(x: detailOffset)
        .allowsHitTesting(isPresented)
        .zIndex(99)
        .onChange(of: isPresented) { oldValue, newValue in
            withAnimation(.smooth(duration: 0.3)) {
                offset = newValue ? -UIScreen.main.bounds.width : 0
                detailOffset = newValue ? 0 : UIScreen.main.bounds.width
            }
        }
    }
}

extension View {
    func detailNavigation<DetailContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> DetailContent
    ) -> some View {
        modifier(DetailNavigationModifier(
            isPresented: isPresented,
            detailContent: content
        ))
    }
}

#Preview {
    ContentView()
        .environmentObject(ContentView.ViewModel())
        .environmentObject(OnboardView.ViewModel(loginStepAction: {}))
        .environmentObject(BottomBar.ViewModel())
}

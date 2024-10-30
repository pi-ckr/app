//
//  BottomSheetModifier.swift
//  Pickr
//
//  Created by  jwkwon0817 on 10/30/24.
//
import SwiftUI

extension View {
    func sizeState(size: Binding<CGSize>) -> some View {
        return background(
            GeometryReader { geometry in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometry.size)
                    .onPreferenceChange(SizePreferenceKey.self) { newSize in
                        size.wrappedValue = newSize
                    }
            }
        )
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}


struct BottomSheetModifier<SheetContent: View>: ViewModifier {
   @Binding var isShowing: Bool
   let sheetContent: () -> SheetContent
   
   @State private var dragOffset: CGFloat = 0
   @State private var bottomSheetSize: CGSize = .zero
   @GestureState private var isDragging: Bool = false
    
    @State private var dragDirection: DragDirection = .none
        
    private enum DragDirection {
        case up, down, none
    }
   
   private var bottomSheetOffset: CGFloat {
       isShowing ? 0 : bottomSheetSize.height
   }
   
   func body(content: Content) -> some View {
       ZStack {
           content
           
           if isShowing {
               Color(hex: "#000000", alpha: 0.62)
                   .ignoresSafeArea()
                   .opacity(isDragging && dragDirection == .down ? 0.3 : 0.62)
                   .animation(.easeInOut(duration: 0.2), value: isDragging)
                   .onTapGesture {
                       withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                           isShowing = false
                       }
                   }
                   .transition(.opacity.animation(.easeInOut(duration: 0.2)))
           }
           
           VStack {
               Spacer()
               VStack(spacing: 0) {
                   HStack {
                       Capsule()
                           .fill(Color.border.primary)
                           .frame(width: 60, height: 4)
                           .padding(.vertical, 15)
                   }
                   .frame(maxWidth: .infinity)
                   .background(Color.background.secondary)
                   .contentShape(Rectangle())
                   
                   sheetContent()
                       .frame(maxHeight: .infinity)
                       .frame(maxWidth: .infinity)
                       .fixedSize(horizontal: false, vertical: true)
               }
               .sizeState(size: $bottomSheetSize)
               .background(Color.background.secondary)
               .cornerRadius(14, corners: [.topLeft, .topRight])
               .offset(y: bottomSheetOffset + dragOffset)
               .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isShowing)
               .scaleEffect(isDragging && dragDirection == .up ? 0.98 : 1.0)  // 위로 드래그할 때만 scale 효과
               .animation(.spring(response: 0.2, dampingFraction: 0.7), value: isDragging)
           }
           .gesture(
               DragGesture()
                   .updating($isDragging) { _, state, _ in
                       state = true
                   }
                   .onChanged { value in
                       dragDirection = value.translation.height > 0 ? .down : .up
                       withAnimation(.interactiveSpring()) {
                           if dragOffset + value.translation.height > 0 {
                               dragOffset = value.translation.height
                           }
                       }
                   }
                   .onEnded { value in
                       withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                           if value.translation.height > 100 || value.predictedEndTranslation.height > 200 {
                               isShowing = false
                           }
                           dragOffset = 0
                       }
                       dragDirection = .none
                   }
           )
           .ignoresSafeArea(edges: .bottom)
       }
       .zIndex(.infinity)
   }
}
extension View {
    func bottomSheet<SheetContent: View>(isShowing: Binding<Bool>, @ViewBuilder sheetContent: @escaping () -> SheetContent) -> some View {
        self.modifier(BottomSheetModifier(isShowing: isShowing, sheetContent: sheetContent))
    }
}

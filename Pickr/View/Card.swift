import SwiftUI

struct Card<Content: View>: View {
    var title: String = "단어장"
    var number: Int?
    let content: Content
    
    init(
        title: String = "단어장",
        number: Int = 0,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.number = number
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text(title)
                    .typography(.title, color: .content.primary)
                if let number {
                    Text("\(number)")
                        .typography(.label, color: .accent.primary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            content
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
    }
}

#Preview {
    Card(title: "단어장", number: 5) {
        Text("Content goes here")
    }
    .background(Color.background.tertiary)
}

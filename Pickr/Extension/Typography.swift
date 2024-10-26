import SwiftUI

struct Typography {
    enum Style {
        case heading, display, largeTitle, title, titleEmphasized, headline, headlineEmphasized, label, labelEmphasized, body, bodyEmphasized, footnote, footnoteEmphasized, caption, captionEmphasized
        
        var fontSize: CGFloat {
            switch self {
            case .heading: return 37
            case .display: return 28
            case .largeTitle: return 24
            case .title, .titleEmphasized: return 20
            case .headline, .headlineEmphasized: return 18
            case .label, .labelEmphasized: return 16
            case .body, .bodyEmphasized: return 14
            case .footnote, .footnoteEmphasized: return 13
            case .caption, .captionEmphasized: return 11
            }
        }
        
        var lineHeight: CGFloat {
            switch self {
            case .heading: return 55
            case .display: return 42
            case .largeTitle: return 36
            case .title, .titleEmphasized: return 30
            case .headline, .headlineEmphasized: return 27
            case .label, .labelEmphasized: return 24
            case .body, .bodyEmphasized: return 21
            case .footnote, .footnoteEmphasized: return 20
            case .caption, .captionEmphasized: return 16
            }
        }
        
        var letterSpacing: CGFloat {
            let ratio = -0.04
            
            return fontSize * ratio
        }
        
        var fontName: String {
            switch self {
            case .heading, .display, .largeTitle, .titleEmphasized:
                return "Pretendard-Bold"
            case .headline, .label, .body:
                return "Pretendard-Medium"
            case .footnote:
                return "Pretendard-Regular"
            case .title, .headlineEmphasized, .labelEmphasized, .bodyEmphasized, .footnoteEmphasized:
                return "Pretendard-SemiBold"
            case .caption, .captionEmphasized:
                return "Pretendard-SemiBold"
            }
        }


    }
}

// Typography Environment Key
struct TypographyEnvironmentKey: EnvironmentKey {
    static let defaultValue: (Typography.Style, Color) -> Font = { style, color in
        return Font.custom(style.fontName, size: style.fontSize)
    }
}

extension EnvironmentValues {
    var typography: (Typography.Style, Color) -> Font {
        get { self[TypographyEnvironmentKey.self] }
        set { self[TypographyEnvironmentKey.self] = newValue }
    }
}

struct TypographyModifier: ViewModifier {
    let style: Typography.Style
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.custom(style.fontName, size: style.fontSize))
            .foregroundColor(color)
            .lineSpacing((style.lineHeight - style.fontSize) / 2)
            .padding(.vertical, (style.lineHeight - style.fontSize) / 4)
            .kerning(style.letterSpacing)
            .fixedSize(horizontal: false, vertical: true)
    }
}

extension View {
    func typography(_ style: Typography.Style, color: Color = .primary) -> some View {
        self.modifier(TypographyModifier(style: style, color: color))
    }
}

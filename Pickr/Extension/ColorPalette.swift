import SwiftUI

extension Color {
    init(light: Color, dark: Color) {
        self.init(uiColor: UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .light:
                return UIColor(light)
            case .dark:
                return UIColor(dark)
            case .unspecified:
                return UIColor(light)
            @unknown default:
                return UIColor(light)
            }
        })
    }
    
    init(hex: String, alpha: Double = 1.0) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: alpha
        )
    }
    
    // Hex 정수값을 사용하는 경우
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    
    static let system = Color(light: Color("System/Black"), dark: Color("System/White"))
    static var background: BackgroundColors.Type { BackgroundColors.self }
    static var content: ContentColors.Type { ContentColors.self }
    static var border: BorderColors.Type { BorderColors.self }
    static var accent: AccentColors.Type { AccentColors.self }
    static var fill: FillColors.Type { FillColors.self }
    static var etc: ETCColors.Type { ETCColors.self }
    static var status: StatusColors.Type { StatusColors.self }
    static var streak: StreakColors.Type { StreakColors.self }
}

enum BackgroundColors {
    static let primary = Color(light: Color("Grayscale/0"), dark: Color("Grayscale/900"))
    static let secondary = Color(light: Color("Grayscale/50"), dark: Color("Grayscale/800"))
    static let tertiary = Color(light: Color("Grayscale/100"), dark: Color("Grayscale/700"))
    static let quaternary = Color(light: Color("Grayscale/300"), dark: Color("Grayscale/600"))
}

enum ContentColors {
    static let primary = Color(light: Color("Grayscale/600"), dark: Color("Grayscale/0"))
    static let secondary = Color(light: Color("Grayscale/300"), dark: Color("Grayscale/300"))
    static let tertiary = Color(light: Color("Grayscale/200"), dark: Color("Grayscale/400"))
    static let invert = Color(light: Color("Grayscale/0"), dark: Color("Grayscale/800"))
}

enum BorderColors {
    static let primary = Color(light: Color("Grayscale/150"), dark: Color("Grayscale/600"))
    static let secondary = Color(light: Color("Grayscale/200"), dark: Color("Grayscale/400"))
    static let tertiary = Color(light: Color("Grayscale/300"), dark: Color("Grayscale/300"))
}

enum AccentColors {
    static let primary = Color(light: Color("Core/300"), dark: Color("Core/300"))
    static let transparent = Color(light: Color("Core/Translucent/100"), dark: Color("Core/Translucent/100"))
}

enum FillColors {
    static let primary = Color(light: Color("Grayscale/50"), dark: Color("Grayscale/500"))
    static let secondary = Color(light: Color("Grayscale/0"), dark: Color("Grayscale/600"))
    static let tertiary = Color(light: Color("Grayscale/300"), dark: Color("Grayscale/700"))
    static let invert = Color(light: Color("Grayscale/800"), dark: Color("Grayscale/0"))
}

enum ETCColors {
    static let bottomNavigationBar = Color(light: Color(hex: "#FFFFFF", alpha: 0.8), dark: Color(hex: "#2F3238", alpha: 0.8))
    static let bottomNavigationBarShadow = Color(light: Color(hex: "#ECEDED", alpha: 0.25), dark: Color(hex: "#000000", alpha: 0.2))
}

enum StatusColors {
    static let success = Color(light: Color("Solid/Green"), dark: Color("Solid/Green"))
    static let danger = Color(light: Color("Solid/Red"), dark: Color("Solid/Red"))
    static let warning = Color(light: Color("Solid/Yellow"), dark: Color("Solid/Yellow"))
}

enum StreakColors {
    static let low = Color(light: Color("Core/100"), dark: Color("Core/600"))
    static let medium = Color(light: Color("Core/200"), dark: Color("Core/500"))
    static let high = Color(light: Color("Core/300"), dark: Color("Core/300"))
}

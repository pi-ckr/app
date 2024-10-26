import SwiftUI

struct ColorPalette {
    struct Background {
        static let Primary = Color("Background/Primary")
        static let Secondary = Color("Background/Secondary")
        static let Tertiary = Color("Background/Tertiary")
        static let Quaternary = Color("Background/Quaternary")
    }
    
    struct Content {
        static let Primary = Color("Content/Primary")
        static let Secondary = Color("Content/Secondary")
        static let Tertiary = Color("Content/Tertiary")
        static let Invert = Color("Content/Invert")
    }
    
    struct Border {
        static let Primary = Color("Border/Primary")
        static let Invert = Color("Border/Invert")
        static let Basic = Color("Border/Basic")
    }
    
    struct Accent {
        static let Primary = Color("Accent/Primary")
        static let Transparent = Color("Accent/Transparent")
    }
    
    struct ETC {
        static let BottomNavigationBar = Color("ETC/BottomNavigationBar")
        static let BottomNavigationBarShadow = Color("ETC/BottomNavigationBarShadow")
    }
}

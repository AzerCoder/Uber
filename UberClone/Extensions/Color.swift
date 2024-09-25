//
//  Color.swift
//  UberClone
//
//  Created by A'zamjon Abdumuxtorov on 25/09/24.
//

import SwiftUI

extension Color{
    static let theme = ColorTheme()
}

struct ColorTheme{
    let bgColor = Color("BackgroundColor")
    let secondaryBgColor = Color("SecondaryBgColor")
    let textColor = Color("TextColor")
}

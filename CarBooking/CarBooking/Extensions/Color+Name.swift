//
//  Color+Name.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 25/05/2023.
//

import SwiftUI

extension Color {
    static subscript(name: String) -> Color? {
        switch name.lowercased() {
        case  "red": return .red
        case  "orange": return .orange
        case  "yellow": return .yellow
        case  "green": return .green
        case  "mint": return .mint
        case  "teal": return .teal
        case  "cyan": return .cyan
        case  "blue": return .blue
        case  "indigo": return .indigo
        case  "purple": return .purple
        case  "pink": return .pink
        case  "brown": return .brown
        case  "white": return .white
        case  "gray": return .gray
        case  "black": return .black

        default: return nil
        }
    }

    static func availableColorsNames() -> [String] {
        [
            "red",
            "orange",
            "yellow",
            "green",
            "mint",
            "teal",
            "cyan",
            "blue",
            "indigo",
            "purple",
            "pink",
            "brown",
            "white",
            "gray",
            "black"
        ]
    }
}

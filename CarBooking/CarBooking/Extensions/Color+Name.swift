//
//  Color+Name.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 25/05/2023.
//

import SwiftUI

extension Color {
    static subscript(name: String) -> Color {
        switch name.lowercased() {
        case  "red": return Color.red
        case  "orange": return Color.orange
        case  "yellow": return Color.yellow
        case  "green": return Color.green
        case  "mint": return Color.mint
        case  "teal": return Color.teal
        case  "cyan": return Color.cyan
        case  "blue": return Color.blue
        case  "indigo": return Color.indigo
        case  "purple": return Color.purple
        case  "pink": return Color.pink
        case  "brown": return Color.brown
        case  "white": return Color.white
        case  "gray": return Color.gray
        case  "black": return Color.black

        default: return Color.accentColor
        }
    }
}

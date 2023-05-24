//
//  Double+SimplifiedPrice.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 25/05/2023.
//

import Foundation

extension Double {
    func getSimplifiedPrice() -> String {
        switch self {

        case 0..<1_000: return String(format: "%.1f", self)
        case 1_000..<1_000_000: return String(format: "%.1f", self/1_000) + "K" // TODO: Handle localization for RTL languages
        default: return String(format: "%.1f", self/1_000_000) + "M" // TODO: Handle localization for RTL languages
        }
    }
}

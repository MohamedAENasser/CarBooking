//
//  FilterCriteria.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 25/05/2023.
//

import SwiftUI

struct FilterCriteria: Equatable {
    var colors: Set<String> = []
    var minPrice: String = ""
    var maxPrice: String = ""
    var noFiltersApplied: Bool {
        colors.isEmpty && minPrice.isEmpty && maxPrice.isEmpty
    }
    var availableColorItems: [ColorItem] = Color.availableColorsNames().map { ColorItem(name: $0, isChecked: false) }

    mutating func resetAll() {
        colors = []
        availableColorItems = availableColorItems.map { item in
            var item = item
            item.isChecked = false
            return item
        }
        minPrice = ""
        maxPrice = ""
    }

    mutating func resetColors() {
        colors = []
        availableColorItems = availableColorItems.map { item in
            var item = item
            item.isChecked = false
            return item
        }
    }


    mutating func resetPrice() {
        minPrice = ""
        maxPrice = ""
    }

    static func == (lhs: FilterCriteria, rhs: FilterCriteria) -> Bool {
        lhs.colors == rhs.colors &&
        lhs.minPrice == rhs.minPrice &&
        lhs.maxPrice == rhs.maxPrice &&
        lhs.availableColorItems == rhs.availableColorItems
    }
}

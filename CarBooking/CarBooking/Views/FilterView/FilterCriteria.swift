//
//  FilterCriteria.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 25/05/2023.
//

import SwiftUI

struct FilterCriteria {
    var colors: Set<String> = []
    var minPrice: String = ""
    var maxPrice: String = ""

    var noFiltersApplied: Bool {
        colors.isEmpty && minPrice.isEmpty && maxPrice.isEmpty
    }

    mutating func reset() {
        colors = []
        minPrice = ""
        maxPrice = ""
    }
}

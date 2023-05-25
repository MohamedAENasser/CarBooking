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

    mutating func update (colors: Set<String>, minPrice: String, maxPrice: String) {
        self.colors = colors
        self.minPrice = minPrice
        self.maxPrice = maxPrice
    }
}

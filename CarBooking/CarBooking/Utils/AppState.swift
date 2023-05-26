//
//  AppState.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 25/05/2023.
//

import Foundation

enum EmptyState {
    case response
    case filter(_ availableOptions: Set<FilterOptions>)
}

enum AppState {
    case loading
    case success(_ fetchedCarList: [Car])
    case refresh(_ filteredCarList: [Car])
    case empty(EmptyState)
}

//
//  AppState.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 25/05/2023.
//

import Foundation

enum AppState {
    case loading
    case success(_ fetchedCarList: [Car])
    case refresh(_ filteredCarList: [Car])
}

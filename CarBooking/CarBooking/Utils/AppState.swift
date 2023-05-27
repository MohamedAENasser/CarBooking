//
//  AppState.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 25/05/2023.
//

import Foundation

enum EmptyState: Equatable {
    case response
    case filter(_ availableOptions: Set<FilterOptions>)
}

enum AppState: Equatable {
    case loading
    case success(_ fetchedCarList: [Car])
    case failure(AppError)
    case refresh(_ filteredCarList: [Car])
    case empty(EmptyState)

    static func == (lhs: AppState, rhs: AppState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading) ,(.success, .success) ,(.failure, .failure) ,(.refresh, .refresh) ,(.empty, .empty):
            return true
        default: return false
        }
    }
}

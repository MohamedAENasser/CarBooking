//
//  AppError.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 24/05/2023.
//

import Foundation

enum AppError: Error {
    case failedToLoadData

    var description: String {
        switch self {
        case .failedToLoadData:
            return "We couldn't load your data\n please try again"
        }
    }
}

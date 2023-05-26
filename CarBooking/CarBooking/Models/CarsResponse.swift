//
//  CarsResponse.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 23/05/2023.
//

import Foundation

// MARK: - CarsResponse
struct CarsResponse: Codable {
    var status: Status
    var cars: [Car]?
}

struct Status: Codable {
    let code: Int
    let message: String
}

// MARK: - Car
struct Car: Codable, Identifiable {
    let id = UUID()
    let model: Int
    let plateNumber: String
    let brand: String
    let unitPrice: Double
    let currency: String
    let color: String

    private enum CodingKeys: String, CodingKey {
        case model, brand, currency, color
        case plateNumber = "plate_number"
        case unitPrice = "unit_price"
    }
}

//
//  CarListViewModel.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 24/05/2023.
//

import Foundation
import Moya
import Combine

class CarListViewModel: ObservableObject {
    private var carsService: CarsServiceProtocol = CarsService()
    @Published var cars: [Car] = []

    @MainActor
    func getAvailableCars() async {
        let result = await carsService.getAvailableCars()
        switch result {
        case .success(let carList):
            cars = carList
        case .failure(let error):
            print(error) // TODO: Error Handling
        }
    }
}

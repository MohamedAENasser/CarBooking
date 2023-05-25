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
    private var carsService: CarsServiceProtocol
    @Published var cars: [Car]
    @Published var filterCriteria: FilterCriteria

    init(carsService: CarsServiceProtocol = CarsService(), cars: [Car] = [], filterCriteria: FilterCriteria = FilterCriteria()) {
        self.carsService = carsService
        self.cars = cars
        self.filterCriteria = filterCriteria

        subscribeForFilterChanges()
    }

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

    private func subscribeForFilterChanges() {
        $filterCriteria.subscribe(Subscribers.Sink(
            receiveCompletion: { _ in
            }, receiveValue: { criteria in
                print(criteria) // TODO: Apply filtration logic here
            })
        )
    }
}

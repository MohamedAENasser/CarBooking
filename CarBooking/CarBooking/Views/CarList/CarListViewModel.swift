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
    private var carList: [Car] = []

    @Published var state: AppState = .loading
    @Published var filterCriteria: FilterCriteria

    init(carsService: CarsServiceProtocol = CarsService(), filterCriteria: FilterCriteria = FilterCriteria()) {
        self.carsService = carsService
        self.filterCriteria = filterCriteria

        subscribeForFilterChanges()
    }

    @MainActor
    func getAvailableCars() async {
        state = .loading
        let result = await carsService.getAvailableCars()
        switch result {
        case .success(let carList):
            self.carList = carList
            state = .success(carList)
        case .failure(let error):
            print(error) // TODO: Error Handling
        }
    }

    // MARK: - Filtration logic
    private func subscribeForFilterChanges() {
        $filterCriteria.subscribe(Subscribers.Sink(
            receiveCompletion: { _ in
            }, receiveValue: { [weak self] criteria in
                guard let self else { return }
                guard !criteria.noFiltersApplied else {
                    state = .refresh(carList)
                    return
                }
                var filteredCarList = carList
                filteredCarList = filteredCarList.filter { car in
                    self.filterColor(car: car, colorList: criteria.colors) &&
                    self.filterMinPrice(car: car, price: criteria.minPrice) &&
                    self.filterMaxPrice(car: car, price: criteria.maxPrice)
                }
                state = .refresh(filteredCarList)
            })
        )
    }

    private func filterColor(car: Car, colorList: Set<String>) -> Bool {
        if colorList.isEmpty { return true }
        return colorList.map {$0.lowercased()}.contains(car.color.lowercased())
    }

    private func filterMinPrice(car: Car, price: String) -> Bool {
        if price.isEmpty { return true }
        return car.unitPrice >= (Double(price) ?? 0)
    }

    private func filterMaxPrice(car: Car, price: String) -> Bool {
        if price.isEmpty { return true }
        return car.unitPrice <= (Double(price) ?? 0)
    }
}

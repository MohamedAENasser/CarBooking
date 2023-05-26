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
            if carList.isEmpty {
                state = .empty(.response)
            } else {
                state = .success(carList)
            }
        case .failure(let error):
            state = .failure(error)
        }
    }
}

// MARK: - Filtration logic
extension CarListViewModel {

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
                var availableFilterOptions: Set<FilterOptions> = []
                filteredCarList = filteredCarList.filter { car in
                    let isValidColor = self.filterColor(car: car, colorList: criteria.colors, availableFilterOptions: &availableFilterOptions)
                    let isValidPrice = self.filterPrice(car: car, minPrice: criteria.minPrice, maxPrice: criteria.maxPrice, availableFilterOptions: &availableFilterOptions)

                    return isValidColor && isValidPrice
                }
                if filteredCarList.isEmpty {
                    state = .empty(.filter(availableFilterOptions))
                } else {
                    state = .refresh(filteredCarList)
                }
            })
        )
    }

    private func filterColor(car: Car, colorList: Set<String>, availableFilterOptions: inout Set<FilterOptions>) -> Bool {
        if colorList.isEmpty { return true }
        let isValid = colorList.map {$0.lowercased()}.contains(car.color.lowercased())
        if isValid {
            availableFilterOptions.insert(.color)
        }
        return isValid
    }

    private func filterPrice(car: Car, minPrice: String, maxPrice: String, availableFilterOptions: inout Set<FilterOptions>) -> Bool {
        var isValid: Bool
        if minPrice.isEmpty && maxPrice.isEmpty {
            return true
        } else if maxPrice.isEmpty {
            isValid = car.unitPrice >= (Double(minPrice) ?? 0)
        } else if minPrice.isEmpty {
            isValid = car.unitPrice <= (Double(maxPrice) ?? 0)
        } else {
            isValid = (Double(minPrice) ?? 0)...(Double(maxPrice) ?? 0) ~= car.unitPrice
        }
        if isValid {
            availableFilterOptions.insert(.price)
        }
        return isValid
    }


    // MARK: - Helper Methods

    func resetAllFilters() {
        filterCriteria.resetAll()
    }

    func resetColorsFilters() {
        filterCriteria.resetColors()
    }


    func resetPriceFilters() {
        filterCriteria.resetPrice()
    }
}

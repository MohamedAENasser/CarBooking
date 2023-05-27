//
//  CarBookingTests.swift
//  CarBookingTests
//
//  Created by Mohamed Abd ElNasser on 27/05/2023.
//

import XCTest
import Moya
@testable import CarBooking

final class CarListViewModelTests: XCTestCase {
    var viewModel: CarListViewModel!

    override class func setUp() {
        CarBookingTarget.stubFileBundle = Bundle.unitTests
    }
    
    override func setUp() {
        super.setUp()

        viewModel = CarListViewModel(carsService: CarsService(provider: MoyaProvider<CarBookingTarget>(stubClosure: MoyaProvider.immediatelyStub)))
    }

    override func tearDown() {
        viewModel = nil

        super.tearDown()
    }

    // MARK: - Test main state scenarios

    func testGetCarListSuccessfully() async {
        // Given
        CarBookingTarget.stubFileName = "success"

        // When
        await viewModel.getAvailableCars()

        // Then
        guard case let .success(carList) = viewModel.state else {
            XCTFail("State should be `success` but it was set to: \(viewModel.state)")
            return
        }
        XCTAssertEqual(carList.count, 8)
    }

    func testGetCarListWithEmptyResponse() async {
        // Given
        CarBookingTarget.stubFileName = "empty"

        // When
        await viewModel.getAvailableCars()

        // Then
        guard case let .empty(emptyState) = viewModel.state else {
            XCTFail("State should be `empty` but it was set to: \(viewModel.state)")
            return
        }
        XCTAssertEqual(emptyState, .response)
    }

    func testGetCarListWithError() async {
        // Given
        CarBookingTarget.stubFileName = "error"

        // When
        await viewModel.getAvailableCars()

        // Then
        guard case let .failure(error) = viewModel.state else {
            XCTFail("State should be `failure` but it was set to: \(viewModel.state)")
            return
        }
        XCTAssertEqual(error, .failedToLoadData)
    }


    // MARK: - Test Filtration logic

    func testFilterCarList_ValidCriteria() async throws {
        // Given
        CarBookingTarget.stubFileName = "success"

        // When
        await viewModel.getAvailableCars()

        // Then
        guard case let .success(carList) = viewModel.state else {
            XCTFail("State should be `success` but it was set to: \(viewModel.state)")
            return
        }

        let firstCar = try XCTUnwrap(carList.first)
        viewModel.filterCriteria = FilterCriteria(colors: [firstCar.color], minPrice: String(firstCar.unitPrice), maxPrice: String(firstCar.unitPrice))

        guard case let .refresh(filteredCarList) = viewModel.state else {
            XCTFail("State should be `refresh` but it was set to: \(viewModel.state)")
            return
        }

        XCTAssertGreaterThanOrEqual(filteredCarList.count, 1)
        XCTAssertTrue(filteredCarList.contains(where: { $0 == firstCar }))
    }

    func testFilterCarList_InvalidCriteria() async throws {
        // Given
        CarBookingTarget.stubFileName = "success"

        // When
        await viewModel.getAvailableCars()

        // Then
        guard case let .success(carList) = viewModel.state else {
            XCTFail("State should be `success` but it was set to: \(viewModel.state)")
            return
        }

        let existingCarColors = carList.map { $0.color.lowercased() }
        let invalidColor = try XCTUnwrap(viewModel.filterCriteria.availableColorItems.first(where: { !existingCarColors.contains($0.name.lowercased()) }))
        viewModel.filterCriteria = FilterCriteria(colors: [invalidColor.name], minPrice: "1000", maxPrice: "1000000")

        guard case let .empty(emptyState) = viewModel.state,
            case let .filter(availableOptions) = emptyState else {
                XCTFail("State should be `empty` but it was set to: \(viewModel.state)")
            return
        }

        XCTAssertTrue(availableOptions.isEmpty)
    }

    func testFilterCarList_InvalidColors_ValidPrice() async throws {
        // Given
        CarBookingTarget.stubFileName = "success"

        // When
        await viewModel.getAvailableCars()

        // Then
        guard case let .success(carList) = viewModel.state else {
            XCTFail("State should be `success` but it was set to: \(viewModel.state)")
            return
        }

        let firstCar = try XCTUnwrap(carList.first)
        let existingCarColors = carList.map { $0.color.lowercased() }
        let invalidColor = try XCTUnwrap(viewModel.filterCriteria.availableColorItems.first(where: { !existingCarColors.contains($0.name.lowercased()) }))
        viewModel.filterCriteria = FilterCriteria(colors: [invalidColor.name], minPrice: String(firstCar.unitPrice), maxPrice: String(firstCar.unitPrice))

        guard case let .empty(emptyState) = viewModel.state,
              case let .filter(availableOptions) = emptyState else {
            XCTFail("State should be `empty` but it was set to: \(viewModel.state)")
            return
        }

        XCTAssertTrue(availableOptions.contains(.price))
    }

    func testFilterCarList_InvalidPrice_ValidColors() async throws {
        // Given
        CarBookingTarget.stubFileName = "success"

        // When
        await viewModel.getAvailableCars()

        // Then
        guard case let .success(carList) = viewModel.state else {
            XCTFail("State should be `success` but it was set to: \(viewModel.state)")
            return
        }

        let firstCar = try XCTUnwrap(carList.first)
        viewModel.filterCriteria = FilterCriteria(colors: [firstCar.color], minPrice: "1000", maxPrice: "1000000")

        guard case let .empty(emptyState) = viewModel.state,
              case let .filter(availableOptions) = emptyState else {
            XCTFail("State should be `empty` but it was set to: \(viewModel.state)")
            return
        }

        XCTAssertTrue(availableOptions.contains(.color))
    }
}

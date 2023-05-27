//
//  CarsService.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 24/05/2023.
//

import Foundation
import Combine
import Moya

protocol CarsServiceProtocol {
    var provider: MoyaProvider<CarBookingTarget> { get set }
    func getAvailableCars() async -> Result<[Car], AppError>
}

final class CarsService: CarsServiceProtocol {
    var provider: MoyaProvider<CarBookingTarget>
    private var cancellable: AnyCancellable?

    init(provider: MoyaProvider<CarBookingTarget> = MoyaProvider<CarBookingTarget>(stubClosure: MoyaProvider.immediatelyStub)) {
        self.provider = provider
    }

    func getAvailableCars() async -> Result<[Car], AppError> {
        return await withCheckedContinuation { continuation in

            // Request data using Moya provider & Combine

            // Setup publisher
            let publisher = provider.requestPublisher(.cars)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: CarsResponse.self, decoder: JSONDecoder())
                .map(\.cars)

            // Setup subscriber
            cancellable = publisher
                .sink(receiveCompletion: { completion in

                    guard case .failure = completion else { return }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Simulate loading state

                        continuation.resume(returning: .failure(.failedToLoadData))

                    }

                }, receiveValue: { response in

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Simulate loading state

                        continuation.resume(returning: .success(response ?? []))

                    }

                })


            // Alternative way to request data using Moya provider

            /*
            provider.request(.cars) { result in
                switch result {
                case .success(let response):
                    do {
                        try continuation.resume(returning: .success(response.map(CarsResponse.self).cars))
                    } catch {
                        return continuation.resume(returning: .failure(.failedToLoadData))
                    }
                case .failure:
                    return continuation.resume(returning: .failure(.failedToLoadData))
                }
            }
             */

        }
    }
}

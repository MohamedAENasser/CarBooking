//
//  Bundle+UnitTests.swift
//  CarBookingTests
//
//  Created by Mohamed Abd ElNasser on 27/05/2023.
//

import Foundation

private class BundleClass {
}

extension Bundle {
    static let unitTests = Bundle(for: BundleClass.self)
}

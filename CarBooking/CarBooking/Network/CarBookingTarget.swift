//
//  CarBookingTarget.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 23/05/2023.
//

import Moya

enum CarBookingTarget {
    case cars
}

extension CarBookingTarget: TargetType {
    var baseURL: URL {
        URL(string: "API_URL")!
    }

    var path: String {
        switch self {

        case .cars:
            return "cars_path"

        }
    }

    var method: Moya.Method {
        switch self {

        case .cars:
            return .get

        }
    }

    var task: Moya.Task {
        switch self {

        case .cars:
            return .requestPlain

        }
    }

    var headers: [String : String]? {
        [:/* Headers */]
    }

    static var stubFileName = "SampleData_success"
    var sampleData: Data {
        guard let path = Bundle.main.path(forResource: CarBookingTarget.stubFileName, ofType: "json") else { return Data() }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
        } catch {
            print(error)
            return Data()
        }
    }
}

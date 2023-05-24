//
//  CarListView.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 24/05/2023.
//

import SwiftUI

struct CarListView: View {
    @StateObject private var viewModel = CarListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.cars, id: \.id) { car in
                CarCell(car: car)
            }
            .navigationTitle("Available Cars")
        }

        .onAppear {
            Task {
                await viewModel.getAvailableCars()
            }
        }
    }
}

struct CarListView_Previews: PreviewProvider {
    static var previews: some View {
        CarListView()
    }
}

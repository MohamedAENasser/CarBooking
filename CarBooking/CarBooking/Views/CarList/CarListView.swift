//
//  CarListView.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 24/05/2023.
//

import SwiftUI

struct CarListView: View {
    @StateObject private var viewModel = CarListViewModel()
    @State private var isFilterViewOpened = false

    var body: some View {
        ZStack {
            //MARK: - Handle App States
            switch viewModel.state {
            case .success(let carList):
                carListView(carList: carList)
            case .loading:
                LoadingView()
            }
        }
        .onAppear {
            Task {
                await viewModel.getAvailableCars()
            }
        }
    }

    func carListView(carList: [Car]) -> some View {
        ZStack {
            NavigationView {
                List(carList, id: \.id) { car in
                    CarCell(car: car)
                }
                .navigationTitle("Available Cars")
                .navigationBarTitleDisplayMode(.inline)

                .toolbar {
                    filterButtonView
                }
            }

            FilterView(isFilterViewVisible: $isFilterViewOpened, filterCriteria: $viewModel.filterCriteria)
        }
    }

    var filterButtonView: some View {
        Button {
            isFilterViewOpened.toggle()
        } label: {
            Image("FilterIcon")
                .resizable()
                .renderingMode(.template)
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(isFilterViewOpened ? Color.blue : Color.red)
        }
    }
}

struct CarListView_Previews: PreviewProvider {
    static var previews: some View {
        CarListView()
    }
}

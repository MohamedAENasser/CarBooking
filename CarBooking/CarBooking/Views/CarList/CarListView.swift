//
//  CarListView.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 24/05/2023.
//

import SwiftUI

struct CarListView: View {
    @EnvironmentObject private var viewModel: CarListViewModel
    @State private var isFilterViewOpened = false

    var body: some View {
        ZStack {
            //MARK: - Handle App States
            switch viewModel.state {
            case let .success(carList), let .refresh(carList):
                carListView(carList: carList)
            case .loading:
                LoadingView()
            case .empty(let type):
                EmptyStateView(type: type, onResetColorFiltersAction: {
                    viewModel.resetColorsFilters()
                }, onResetPriceFiltersAction: {
                    viewModel.resetPriceFilters()
                }, onResetAllFiltersAction: {
                    viewModel.resetAllFilters()
                })
            case .failure(let error):
                ErrorStateView(error: error) {
                    Task {
                        await viewModel.getAvailableCars()
                    }
                }
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
                    NavigationLink {
                        CarDetailsView(car: car)
                    } label: {
                        CarCell(car: car)
                    }
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
                .foregroundColor(viewModel.filterCriteria.noFiltersApplied ? Color.black : Color.blue)
        }
    }
}

struct CarListView_Previews: PreviewProvider {
    static var previews: some View {
        CarListView()
    }
}

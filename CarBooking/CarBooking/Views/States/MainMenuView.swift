//
//  MainMenuView.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 27/05/2023.
//

import SwiftUI

struct MainMenuView: View {
    @StateObject private var viewModel = CarListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                navigationButton(title: "Browse car list", stubFileName: "SampleData_success")
                    .padding(.bottom, 50)
                navigationButton(title: "Empty Response", stubFileName: "SampleData_no_content")
                navigationButton(title: "Error Response", stubFileName: "SampleData_error")
            }
            .padding()
        }
    }

    func navigationButton(title: String, stubFileName: String) -> some View {
        NavigationLink {
            CarListView()
                .environmentObject(viewModel)

        } label: {
            Text(title)
                .font(.title)
                .padding(20)
                .foregroundColor(.white)
                .background(.blue)
                .clipShape(Capsule())
        } .simultaneousGesture(TapGesture().onEnded {
            CarBookingTarget.stubFileName = stubFileName
        })
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}

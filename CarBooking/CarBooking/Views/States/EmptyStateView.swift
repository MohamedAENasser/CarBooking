//
//  EmptyStateView.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 26/05/2023.
//

import SwiftUI

struct EmptyStateView: View {
    var type: EmptyState
    var onResetColorFiltersAction: (() -> Void)?
    var onResetPriceFiltersAction: (() -> Void)?
    var onResetAllFiltersAction: (() -> Void)?

    var body: some View {
        
        switch type {

        case .response:

            titleView(title: "There are no available cars in the meantime.", description: "Stay tuned! 🔥")

        case .filter(let availableOptions):

            VStack {

                titleView(title: "Sorry, we didn't find available cars with these criteria.", description: "You still can find")

                if availableOptions.contains(.color) {
                    availableColorsActionView
                }

                if availableOptions.contains(.price) {
                    availablePriceActionView
                }

                resetAllFiltersView
            }
            .font(.title3)

        }

    }

    func titleView(title: String, description: String) -> some View {
        VStack {
            Text(title)
                .font(.title)

            Text(description)
                .font(.title3).bold()
                .padding(.top, 20)
        }
        .multilineTextAlignment(.center)
        .padding()
    }

    var availableColorsActionView: some View {
        Button {
            onResetPriceFiltersAction?()
        } label: {
            Text("Different prices for specified colors")
                .foregroundColor(.white)
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        .background(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)).foregroundColor(.blue))
    }

    var availablePriceActionView: some View {
        Button {
            onResetColorFiltersAction?()
        } label: {
            Text("Different colors for specified price")
                .foregroundColor(.white)
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        .background(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)).foregroundColor(.blue))
    }

    var resetAllFiltersView: some View {
        Button {
            onResetAllFiltersAction?()
        } label: {
            Text("All available cars")
                .foregroundColor(.white)
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        .background(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)).foregroundColor(.blue))
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmptyStateView(type: .response)
            EmptyStateView(type: .filter([.color, .price]))
            EmptyStateView(type: .filter([.color]))
            EmptyStateView(type: .filter([.price]))
            EmptyStateView(type: .filter([]))
        }
    }
}

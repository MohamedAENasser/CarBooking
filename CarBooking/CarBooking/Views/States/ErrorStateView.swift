//
//  ErrorStateView.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 27/05/2023.
//

import SwiftUI

struct ErrorStateView: View {
    var error: AppError
    var onTapReTry: () -> Void

    var body: some View {
        VStack {
            Image("Warning-icon")
                .resizable()
                .frame(width: 150, height: 150)
                .padding(.bottom, 50)

            Text(error.description)
                .font(.title)
                .multilineTextAlignment(.center)

            Button {
                onTapReTry()
            } label: {
                Label("Try Again", systemImage: "arrow.counterclockwise")
                    .labelStyle(.iconOnly)
                    .foregroundColor(.black)
            }
            .buttonStyle(.borderless)
            .scaleEffect(3)
            .padding(.top, 20)
        }
    }
}

struct ErrorStateView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorStateView(error: AppError.failedToLoadData, onTapReTry: {})
    }
}

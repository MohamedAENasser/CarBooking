//
//  LoadingView.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 25/05/2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Color.gray.ignoresSafeArea(.all)

        ProgressView()
            .progressViewStyle(.automatic)
            .scaleEffect(4)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

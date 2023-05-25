//
//  FilterView.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 25/05/2023.
//

import SwiftUI

struct FilterView: View {

    @Binding var isFilterViewVisible: Bool

    @State private var minPrice: String = ""
    @State private var maxPrice: String = ""
    @FocusState private var inputIsFocused: Bool

    let screenWidth = UIScreen.main.bounds.size.width
    var filterViewWidth = UIScreen.main.bounds.size.width * 0.6

    var body: some View {
        ZStack {
            backgroundView

            contentView
        }
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            inputIsFocused = false
        }
    }

    var backgroundView: some View {
        GeometryReader { _ in
            EmptyView()
        }
        .background(.black.opacity(0.6))
        .opacity(isFilterViewVisible ? 1 : 0)
        .animation(.easeInOut.delay(0.2), value: isFilterViewVisible)
        .onTapGesture {
            inputIsFocused = false
            isFilterViewVisible.toggle()
        }
    }

    var contentView: some View {
        HStack(alignment: .top) {
            ZStack(alignment: .top) {
                Color.cyan.opacity(0.9)

                VStack {
                    List {
                        Section(header: Text("Color").font(.title3).fontWeight(.bold)) {
                            ForEach(["Red", "Green", "Blue"], id: \.self) { color in
                                CheckListItem(title: color)
                            }
                        }

                        Section(header: Text("Price").font(.title3).fontWeight(.bold)) {
                            TextField("Min", text: $minPrice)
                            TextField("Max", text: $maxPrice)
                        }
                        .keyboardType(.numberPad)
                        .focused($inputIsFocused)
                    }
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                    .listStyle(.grouped)
                }
            }
            .frame(width: filterViewWidth)
            .offset(x: isFilterViewVisible ? screenWidth - filterViewWidth : screenWidth * 2 )
            .animation(.default, value: isFilterViewVisible)

            Spacer()
        }
    }

    
}

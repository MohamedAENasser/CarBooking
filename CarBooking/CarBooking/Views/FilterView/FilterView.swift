//
//  FilterView.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 25/05/2023.
//

import SwiftUI

struct FilterView: View {

    @Binding var isFilterViewVisible: Bool
    @Binding var filterCriteria: FilterCriteria

    @FocusState private var inputIsFocused: Bool

    @State private var minPrice: String = ""
    @State private var maxPrice: String = ""
    @State private var filterColors: Set<String> = []

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

                        priceSectionView

                        colorSectionView

                        applySectionView

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
        .onAppear {
            filterColors = filterCriteria.colors
        }
    }

    var priceSectionView: some View {
        Section(header: Text("Price").font(.title3).fontWeight(.bold)) {
            TextField("Minimum", text: $minPrice)
            TextField("Maximum", text: $maxPrice)
        }
        .keyboardType(.numberPad)
        .focused($inputIsFocused)
    }

    var colorSectionView: some View {
        Section(header: Text("Color").font(.title3).fontWeight(.bold)) {
            ForEach(Color.availableColorsNames(), id: \.self) { color in
                CheckListItem(isChecked: filterColors.contains(color), title: color) { isChecked in
                    if isChecked {
                        filterColors.insert(color)
                    } else {
                        filterColors.remove(color)
                    }
                }
            }
        }
    }

    var applySectionView: some View {
        HStack {

            Spacer()

            Text("Apply")
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .foregroundColor(Color.white)
                .background(Color.blue)
                .clipShape(Capsule())
                .onTapGesture {
                    filterCriteria.update(colors: filterColors, minPrice: minPrice, maxPrice: maxPrice)
                    inputIsFocused = false
                    isFilterViewVisible.toggle()
                }

            Spacer()
        }
    }
}

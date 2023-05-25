//
//  CheckListItem.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 25/05/2023.
//

import SwiftUI

struct ColorItem {
    var name: String
    var isChecked: Bool
}

struct ColorPaletteView: View {
    @State var colorItems: [ColorItem] = []
    var onTapAction: ((_ index: Int, _ isChecked: Bool) -> Void)?

    var body: some View {

        ScrollView(.vertical) {
            let count = colorItems.count
            let columnCount = 4
            let rowCount = (Double(count) / Double(columnCount)).rounded(.up)

            ForEach(0..<Int(rowCount), id: \.self) { row in

                Spacer(minLength: 8)

                HStack(spacing: 8) {

                    ForEach(0..<columnCount, id: \.self) { column in
                        let index = row * columnCount + column
                        if index < count {
                            Color[colorItems[index].name]
                                .aspectRatio(1, contentMode: .fit)
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .stroke(colorItems[index].isChecked ? .blue : .black, lineWidth: colorItems[index].isChecked ? 5 : 1)
                                }
                                .onTapGesture {
                                    colorItems[index].isChecked.toggle()
                                    onTapAction?(index, colorItems[index].isChecked)
                                }
                        } else {
                            Spacer().frame(maxWidth: .infinity)
                        }
                    }

                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))

            }

        }.frame(maxWidth: .infinity)

    }
}

struct ColorPaletteView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPaletteView(colorItems: [ColorItem(name: "Red", isChecked: true), ColorItem(name: "Green", isChecked: false)])
    }
}

//
//  CarCell.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 25/05/2023.
//

import SwiftUI

struct CarCell: View {
    let car: Car

    var body: some View {
        HStack {
            priceView

            Spacer()

            brandView

            Spacer()

            carView
        }
    }

    var priceView: some View {
        Text("\(car.unitPrice.getSimplifiedPrice()) \(car.currency)")
    }

    var brandView: some View {
        Text(car.brand)
            .font(Font.title3.bold())
            .padding(6)
            .background(Color.cyan.opacity(0.3))
            .clipShape(Capsule(style: .continuous))
    }

    var carView: some View {
        HStack {

            Divider()

            ZStack {
                Color.gray.opacity(0.2)
                Image("CarOutline")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(Color[car.color])
            }
            .carImageStyle()
        }
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
    }
}

struct CarImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 75, height: 75, alignment: .center)
            .clipShape(Circle())
    }
}

extension View {
    func carImageStyle() -> some View {
        modifier(CarImageModifier())
    }
}

struct CarCell_Previews: PreviewProvider {
    static var previews: some View {
        CarCell(car: Car(model: 2021, plateNumber: "ABC 123", brand: "Honda", unitPrice: 31400000.5, currency: "EGP", color: "RED"))
    }
}
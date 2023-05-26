//
//  CarDetailsView.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 26/05/2023.
//

import SwiftUI

struct CarDetailsView: View {
    @State var car: Car
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4)

            VStack {

                carImageView

                brandDetailView

                getDetailRow(key: "Model Year", value: String(car.model))

                getDetailRow(key: "Price", value: "\(car.unitPrice.removeTrailingZeros()) \(car.currency)")

                Spacer()
            }

        }
        .ignoresSafeArea(.all)
    }

    var carImageView: some View {
        Image("CarOutline")
            .renderingMode(.template)
            .resizable()
            .foregroundColor(Color[car.color])
            .frame(width: UIScreen.main.bounds.size.width * 0.8, height: 350)
            .aspectRatio(contentMode: .fill)
    }

    var brandDetailView: some View {
        VStack {
            HStack {
                Spacer()

                Image(car.brand.lowercased())
                    .resizable()
                    .frame(width: 60, height: 60, alignment: .center)


                Text(car.brand)
                    .font(.title).bold()

                Spacer()

                Text("\(car.plateNumber)")
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .font(.title).bold()
                    .background {
                        RoundedRectangle(cornerSize: CGSize(width: 5, height: 5))
                            .stroke(.black)
                            .shadow(radius: 15, y: 5)
                    }

                Spacer()
            }

            Divider()
        }
    }

    func getDetailRow(key: String, value: String) -> some View {
        VStack {
            HStack {

                Text(String(key))
                    .font(.title3).bold()

                Spacer()

                Text(String(value))
            }
            .padding(10)

            Divider()
        }
    }
}

struct CarDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CarDetailsView(car: Car(model: 2021, plateNumber: "ABC 123", brand: "Honda", unitPrice: 31400000.5, currency: "EGP", color: "RED"))
    }
}

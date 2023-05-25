//
//  CheckListItem.swift
//  CarBooking
//
//  Created by Mohamed Abd ElNasser on 25/05/2023.
//

import SwiftUI

struct CheckListItem: View {
    @State var isChecked: Bool = false

    var title: String

    var body: some View {
        HStack{
            Image(systemName: isChecked ? "checkmark.square" : "square")
                .renderingMode(.template)
                .foregroundColor(Color.blue)
            
            Text(title)
            Spacer()
            Color[title]
                .frame(width: 20, height: 20, alignment: .center)
                .clipShape(Capsule())
        }
        .onTapGesture {
            isChecked.toggle()
        }
    }
}

struct CheckListItem_Previews: PreviewProvider {
    static var previews: some View {
        CheckListItem(title: "Title")
    }
}

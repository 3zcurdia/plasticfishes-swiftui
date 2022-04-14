//
//  FishRowView.swift
//  PlasticFishes
//
//  Created by Luis Ezcurdia on 14/04/22.
//

import SwiftUI

struct FishRowView: View {
    let fish: Fish
    var body: some View {
        HStack {
            AsyncImage(url: fish.imageUrl) { image in
                image
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
            } placeholder: {
                Image(systemName: "checkmark.icloud")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.secondary)
            }
            VStack(alignment: .leading) {
                Text(fish.name)
                    .font(.title2)
                    .foregroundColor(.primary)
                Text(fish.uuid)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
    }
}
struct FishRowView_Previews: PreviewProvider {
    static let fish = Fish(id: "blue", name: "Blue Fish", text: "", uuid: "1234-123456-23456-3456")

    static var previews: some View {
        FishRowView(fish: fish)
    }
}

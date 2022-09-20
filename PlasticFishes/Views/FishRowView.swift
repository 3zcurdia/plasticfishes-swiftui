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
            CachedAsyncImage(url: fish.imageUrl) { phase in
                switch phase {
                case .empty:
                    Image(systemName: "icloud.and.arrow.down")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                case .success(let image):
                    image
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                default:
                    Image(systemName: "xmark.icloud")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.secondary)
                }
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

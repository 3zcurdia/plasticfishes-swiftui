//
//  FishDetailView.swift
//  PlasticFishes
//
//  Created by Luis Ezcurdia on 14/04/22.
//

import SwiftUI

struct FishDetailView: View {
    let fish: Fish
    var body: some View {
        ScrollView {
            DetailHeader(fishUrl: fish.imageUrl)
                .ignoresSafeArea(edges: .top)
            VStack(alignment: .leading) {
                Group {
                    Text(fish.name)
                        .font(.title)
                    Text(fish.uuid)
                        .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding(.horizontal)

                Divider()

                Text(fish.text)
                    .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FishDetailView_Previews: PreviewProvider {
    static let fish = Fish(
        id: "blue",
        name: "Blue Fish",
        text: "lorem ipsum dolor quet sit amet consectetur adipsum lorem ipsum dolor quet sit amet consectetur adipsum",
        uuid: "1234-123456-23456-3456"
    )

    static var previews: some View {
        FishDetailView(fish: fish)
    }
}

struct DetailHeader: View {
    let fishUrl: URL
    var body: some View {
        ZStack {
            Image("sea")
                .resizable()
                .scaledToFit()
                .frame(height: 250)
                .clipped()
            AsyncImage(url: fishUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
            } placeholder: {
                Image(systemName: "checkmark.icloud")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 128, height: 128)
                    .foregroundColor(.secondary)
            }
        }
    }
}

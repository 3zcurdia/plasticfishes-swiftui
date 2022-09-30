//
//  FishDetailView.swift
//  PlasticFishes
//
//  Created by Luis Ezcurdia on 14/04/22.
//

import SwiftUI

struct FishDetailView: View {
    @Environment(\.dismiss) var dismiss
    let fish: Fish
    var body: some View {
        ScrollView {
            DetailHeader(fishUrl: fish.imageUrl)
            VStack(alignment: .leading) {
                Text(fish.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                Text(fish.uuid)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding([.horizontal, .bottom])
                Text(fish.text)
                    .padding(.horizontal)
            }.padding()
        }
        .ignoresSafeArea(.all, edges: .top)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }

            }
        }
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
                .scaledToFill()
                .frame(height: 280)
                .clipped()
            CachedAsyncImage(url: fishUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 200, height: 200)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                default:
                    Image(systemName: "xmark.icloud")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 128, height: 128)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

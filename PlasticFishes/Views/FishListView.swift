//
//  FishListView.swift
//  PlasticFishes
//
//  Created by Luis Ezcurdia on 14/04/22.
//

import SwiftUI

struct FishListView: View {
    @ObservedObject var fishesVM = FishesViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(fishesVM.fishes) { fish in
                        NavigationLink {
                            FishDetailView(fish: fish)
                        } label: {
                            FishRowView(fish: fish)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("🐟 PlasticFishes")
            .task { await fishesVM.fetch() }
        }
    }
}

struct FishListView_Previews: PreviewProvider {
    static var previews: some View {
        FishListView()
    }
}

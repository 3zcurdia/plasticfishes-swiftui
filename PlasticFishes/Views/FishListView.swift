//
//  FishListView.swift
//  PlasticFishes
//
//  Created by Luis Ezcurdia on 14/04/22.
//

import SwiftUI

struct FishListView: View {
    @ObservedObject var viewModel = FishesViewModel()
    @State var searchText = ""

    var body: some View {
        NavigationView {
            List(viewModel.fishes) { fish in
                NavigationLink {
                    FishDetailView(fish: fish)
                } label: {
                    FishRowView(fish: fish)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("PlasticFishes")
            .searchable(text: $searchText)
            .onChange(of: searchText) { viewModel.filterBy($0) }
            .task {
                await viewModel.fetch()
            }
        }
    }
}

struct FishListView_Previews: PreviewProvider {
    static var previews: some View {
        FishListView()
    }
}

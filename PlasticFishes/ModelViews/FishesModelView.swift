//
//  FishesModelView.swift
//  PlasticFishes
//
//  Created by Luis Ezcurdia on 14/04/22.
//

import Foundation

class FishesViewModel: ObservableObject {
    @Published var fishes: [Fish] = []

    @MainActor
    func fetch() async {
        let url = URL(string: "https://plasticfishes.herokuapp.com/api/fishes")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            self.fishes = try JSONDecoder().decode([Fish].self, from: data)
        } catch {
            print("Oups an error occur!!")
        }
    }
}

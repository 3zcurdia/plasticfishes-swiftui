//
//  FishesModelView.swift
//  PlasticFishes
//
//  Created by Luis Ezcurdia on 14/04/22.
//

import Foundation
import Amaca

class FishesViewModel: ObservableObject {
    @Published var fishes: [Fish] = []
    let endpoint: Amaca.Endpoint<Fish> = Amaca.Endpoint<Fish>(client: API.client, route: "/api/fishes")

    @MainActor
    func fetch() async {
        do {
            self.fishes = try await endpoint.show()
        } catch {
            print("Oups an error occur!!")
        }
    }
}

//
//  FishesModelView.swift
//  PlasticFishes
//
//  Created by Luis Ezcurdia on 14/04/22.
//

import Foundation
import Amaca

extension Amaca {
    struct FishesApiCacheHandler: CacheResponseDelegate {
        let bucket: StorageBucket

        init() {
            bucket = StorageBucket(type: .cache)
        }

        func willMakeRequest(urlRequest: URLRequest) {}

        func fetchCachedRequest(urlRequest: URLRequest) -> Data? {
            return bucket.read("fishes.json")
        }

        func didFinishRequestSuccessful(data: Data?) {
            guard let data = data else { return }
            _ = bucket.writeUnlessExist("fishes.json", data: data)
        }

        func didFinishRequestUnsuccessful(urlRequest: URLRequest, data: Data?) {}
    }
}

@MainActor
class FishesViewModel: ObservableObject {
    @Published var fishes: [Fish] = []
    private var result: [Fish] = []
    var apiClient: Amaca.Client = {
        var client = API.client
        client.cacheDelegate = Amaca.FishesApiCacheHandler()
        return client
    }()
    lazy var endpoint: Amaca.Endpoint<Fish> = {
        return Amaca.Endpoint<Fish>(client: apiClient, route: "/api/fishes")
    }()

    func filterBy(_ text: String) {
        if text.isEmpty {
            fishes = result
        } else {
            fishes = result.filter { fish in
                fish.name.lowercased().contains(text.lowercased())
            }
        }
    }

    func fetch() async {
        do {
            self.result = try await endpoint.show()
            self.fishes = self.result
        } catch let error {
            debugPrint(error)
            print("Oups an error occur!!")
        }
    }
}

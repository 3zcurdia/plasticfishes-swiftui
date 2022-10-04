//
//  CachedAsyncImageViewModel.swift
//  PlasticFishes
//
//  Created by Luis Ezcurdia on 19/09/22.
//

import Foundation
import SwiftUI
import Combine

class CachedAsyncImageViewModel: ObservableObject {
    enum CachedAsyncImageError: Error {
        case loading(String)
    }

    @Published var phase: AsyncImagePhase

    private let url: URL
    private var manager: DataCacheManager = DataCache.shared
    private lazy var urlHash: String = {
        return Checksum.sha1(url.absoluteString)
    }()
    private var cancellableSet = Set<AnyCancellable>()

    init(url: URL) {
        self.url = url
        self.phase = .empty
        load()
    }

    func load() {
        if let data = manager[urlHash],
           let image = image(from: data) {
            self.phase = .success(image)
            return
        }
        URLSession
            .shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .receive(on: RunLoop.main)
            .sink {
                debugPrint("Completed with: \($0)")
            } receiveValue: { data in
                if let image = self.image(from: data) {
                    self.phase = .success(image)
                    self.manager[self.urlHash] = data
                } else {
                    self.phase = .failure(CachedAsyncImageError.loading("Unable to fetch image"))
                }
            }
            .store(in: &cancellableSet)
    }

    private func image(from data: Data) -> Image? {
#if os(macOS)
        guard let nsImage = NSImage(data: data) else { return nil }

        return Image(nsImage: nsImage)
#else
        guard let uiImage = UIImage(data: data) else { return nil }

        return Image(uiImage: uiImage)
#endif
    }
}

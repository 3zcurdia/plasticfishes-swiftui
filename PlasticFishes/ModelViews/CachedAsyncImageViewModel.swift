//
//  CachedAsyncImageViewModel.swift
//  PlasticFishes
//
//  Created by Luis Ezcurdia on 19/09/22.
//

import Foundation
import SwiftUI

@MainActor
class CachedAsyncImageViewModel: ObservableObject {
    enum CachedAsyncImageError: Error {
        case loading(String)
    }

    @Published var phase: AsyncImagePhase
    let url: URL
    var manager: DataCacheManager = DataCache.shared
    lazy var urlHash: String = {
        return Checksum.sha1(url.absoluteString)
    }()

    init(url: URL) {
        self.url = url
        self.phase = .empty
    }

    func load() async {
        if let data = manager[urlHash],
           let image = image(from: data) {
            self.phase = .success(image)
            return
        }
        guard let (data, _) = try? await URLSession.shared.data(from: url),
              let image = image(from: data) else {
            self.phase = .failure(CachedAsyncImageError.loading("Unable to fetch image"))
                  return
        }

        self.phase = .success(image)
        manager[urlHash] = data
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

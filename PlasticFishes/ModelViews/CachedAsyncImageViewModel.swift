//
//  CachedAsyncImageViewModel.swift
//  PlasticFishes
//
//  Created by Luis Ezcurdia on 19/09/22.
//

import Foundation
import SwiftUI

class CachedAsyncImageViewModel: ObservableObject {
    enum CachedAsyncImageError: Error {
        case loading(String)
    }

    @Published var phase: AsyncImagePhase
    let url: URL
    var manager: ImageCacheManager?
    lazy var urlHash: String = {
        return Checksum.sha1(url.absoluteString)
    }()

    init(url: URL, cacheManager: ImageCacheManager? = nil) {
        self.url = url
        self.manager = cacheManager
        self.phase = .empty
    }

    func load() async {
        if let image = manager?[urlHash] {
            self.phase = .success(Image(uiImage: image))
            return
        }
        guard let (data, _) = try? await URLSession.shared.data(from: url),
              let uiImage = UIImage(data: data) else {
            self.phase = .failure(CachedAsyncImageError.loading("Unable to fetch image"))
                  return
        }

        self.phase = .success(Image(uiImage: uiImage))
        manager?[urlHash] = uiImage
    }
}

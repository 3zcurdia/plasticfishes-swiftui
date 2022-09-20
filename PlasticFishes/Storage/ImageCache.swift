//
//  ImageCache.swift
//  PlasticFishes
//
//  Created by Luis Ezcurdia on 19/09/22.
//

import Foundation
import SwiftUI

protocol ImageCacheManager {
    func read(key: String) -> UIImage?
    func write(key: String, image: UIImage)
}

extension ImageCacheManager {
    subscript(index: String) -> UIImage? {
        get {
            read(key: index)
        }
        set(newValue) {
            guard let image = newValue else { return }
            write(key: index, image: image)
        }
    }
}

struct ImageCache: ImageCacheManager {
    static let shared = ImageCache()
    var mem = ImageMemoryCache()
    var dsk = ImageDiskCache()

    func read(key: String) -> UIImage? {
        if let memImage = mem[key] {
            return memImage
        }
        guard let dskImg = dsk[key] else { return nil }

        mem.write(key: key, image: dskImg)
        return dskImg
    }

    func write(key: String, image: UIImage) {
        mem.write(key: key, image: image)
        dsk.write(key: key, image: image)
    }
}

struct ImageMemoryCache: ImageCacheManager {
    typealias ImageCacheType = NSCache<NSString, UIImage>
    static let shared = ImageMemoryCache()
    var memcache: ImageCacheType = {
        let cache = ImageCacheType()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100Mb
        return cache
    }()

    func read(key: String) -> UIImage? {
        return memcache.object(forKey: key as NSString)
    }

    func write(key: String, image: UIImage) {
        memcache.setObject(image, forKey: key as NSString)
    }
}

struct ImageDiskCache: ImageCacheManager {
    static let shared = ImageDiskCache()
    let bucket = StorageBucket(type: .cache)

    func read(key: String) -> UIImage? {
        guard let data = bucket.read(key) else { return nil }

        return UIImage(data: data)
    }

    func write(key: String, image: UIImage) {
        guard let data = image.pngData() else { return }

        _ = bucket.writeUnlessExist(key, data: data)
    }
}

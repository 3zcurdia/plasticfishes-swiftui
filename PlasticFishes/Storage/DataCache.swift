//
//  DataCache.swift
//  PlasticFishes
//
//  Created by Luis Ezcurdia on 20/09/22.
//

import Foundation
import SwiftUI

protocol DataCacheManager {
    func read(key: String) -> Data?
    func write(key: String, data: Data)
}

extension DataCacheManager {
    subscript(index: String) -> Data? {
        get {
            read(key: index)
        }
        set(newValue) {
            guard let data = newValue else { return }
            write(key: index, data: data)
        }
    }
}

struct DataCache: DataCacheManager {
    static let shared = DataCache()
    let memCache = DataMemoryCache()
    let dskCache = DataDiskCache()

    func read(key: String) -> Data? {
        if let cached = memCache.read(key: key) {
            return cached
        } else if let cached = dskCache.read(key: key) {
            memCache.write(key: key, data: cached)
            return cached
        } else {
            return nil
        }
    }

    func write(key: String, data: Data) {
        memCache.write(key: key, data: data)
        dskCache.write(key: key, data: data)
    }
}

struct DataMemoryCache: DataCacheManager {
    typealias DataCacheType = NSCache<NSString, NSData>
    static let shared = DataMemoryCache()
    var memcache: DataCacheType = {
        let cache = DataCacheType()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100Mb
        return cache
    }()

    func read(key: String) -> Data? {
        return memcache.object(forKey: key as NSString) as Data?
    }

    func write(key: String, data: Data) {
        memcache.setObject(data as NSData, forKey: key as NSString)
    }
}

struct DataDiskCache: DataCacheManager {
    static let shared = DataDiskCache()
    let bucket = StorageBucket(type: .cache)

    func read(key: String) -> Data? {
        return bucket.read(key)
    }

    func write(key: String, data: Data) {
        _ = bucket.writeUnlessExist(key, data: data)
    }
}

//
//  StorageBucket.swift
//  PlasticFishes
//
//  Created by Luis Ezcurdia on 04/09/22.
//

import Foundation

struct StorageBucket {
    let baseUrl: URL

    init(type: StorageType) {
        type.ensureExists()
        baseUrl = type.url
    }

    func remove(_ filename: String) {
        try? FileManager.default.removeItem(at: url(for: filename))
    }

    func read(_ filename: String) -> Data? {
        return try? Data(contentsOf: url(for: filename))
    }

    func writeUnlessExist(_ filename: String, data: Data) -> Bool {
        if FileManager.default.fileExists(atPath: url(for: filename).path) {
            return true
        }
        return write(filename, data: data)
    }

    func write(_ filename: String, data: Data) -> Bool {
        do {
            try data.write(to: url(for: filename))
            return true
        } catch let err {
            #if DEBUG
            debugPrint(err)
            #endif
            return false
        }
    }

    private func url(for filename: String) -> URL  {
        var url = baseUrl
        url.appendPathComponent(filename)
        return url
    }
}

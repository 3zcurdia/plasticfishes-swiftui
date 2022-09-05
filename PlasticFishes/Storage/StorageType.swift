//
//  StorageType.swift
//  PlasticFishes
//
//  Created by Luis Ezcurdia on 04/09/22.
//

import Foundation

enum StorageType {
    static func ensureExist() {
        cache.ensureExists()
        application.ensureExists()
        user.ensureExists()
    }

    case cache
    case application
    case user

    var pathDirectory: FileManager.SearchPathDirectory {
        switch self {
        case .cache:
            return .cachesDirectory
        default:
            return .documentDirectory
        }
    }

    var domainMask: FileManager.SearchPathDomainMask {
        switch self {
        case .cache:
            return .localDomainMask
        case .application:
            return .localDomainMask
        case .user:
            return .userDomainMask
        }
    }

    var url: URL {
        var url = FileManager.default.urls(for: pathDirectory, in: domainMask).first!
        let applicationPath = "com.3zcurdia.plasticfishes"
        url.appendPathComponent(applicationPath)
        return url
    }

    var path: String {
        return url.path
    }

    func ensureExists() {
        var isDir: ObjCBool = false
        if FileManager.default.fileExists(atPath: path, isDirectory: &isDir) {
            if isDir.boolValue { return }
            try? FileManager.default.removeItem(at: url)
        }
        try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: false)
    }
}

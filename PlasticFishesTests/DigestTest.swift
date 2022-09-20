//
//  DigestTest.swift
//  PlasticFishesTests
//
//  Created by Luis Ezcurdia on 19/09/22.
//

import XCTest
import CryptoKit
@testable import PlasticFishes

final class DigestTest: XCTestCase {
    let lipsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent a tellus eu elit rhoncus bibendum."
    
    func sha256(_ string: String) -> String {
        guard let data = string.data(using: .utf8) else { return "" }

        return SHA256.hash(data: data).map { String(format: "%02hhx", $0 )}.joined()
    }

    func testSha1() throws {
        XCTAssertEqual("95cd2d49d65f4915e10558a29961f379f2a3e10a", Checksum.sha1(lipsum))
    }

    func testSha2() throws {
        XCTAssertEqual("0c3344107dd49c4819e136d09617601f9b0c19c9ccaed117ad18b3ac2cc5ed69", Checksum.sha256(lipsum))
    }

    func testPerformanceSha2() throws {
        // This is an example of a performance test case.
        self.measure {
            for _ in 1...100 {
                _ = Checksum.sha1(lipsum)
            }
        }
    }

}

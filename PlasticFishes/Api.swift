//
//  Api.swift
//  PlasticFishes
//
//  Created by Luis Ezcurdia on 25/07/22.
//

import Foundation
import Amaca

struct API {
    static let host = "https://plasticfishes.onrender.com/"
    static var client: Amaca.Client = {
        return Amaca.Client(host, session: URLSession.shared)
    }()
}

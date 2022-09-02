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
    static let client = Amaca.Client("https://plasticfishes.onrender.com/", session: URLSession.shared)
}

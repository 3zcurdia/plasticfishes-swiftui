//
//  Api.swift
//  PlasticFishes
//
//  Created by Luis Ezcurdia on 25/07/22.
//

import Foundation
import Amaca

struct API {
    static let client = Amaca.Client("https://plasticfishes.herokuapp.com/", session: URLSession.shared)
}

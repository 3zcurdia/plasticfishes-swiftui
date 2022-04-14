//
//  Fish.swift
//  PlasticFishes
//
//  Created by Luis Ezcurdia on 14/04/22.
//

import Foundation

struct Fish: Codable, Identifiable {
    let id: String
    let name: String
    let text: String
    let uuid: String

    var imageUrl: URL {
        URL(string: "https://plasticfishes.herokuapp.com/\(id).png")!
    }
}

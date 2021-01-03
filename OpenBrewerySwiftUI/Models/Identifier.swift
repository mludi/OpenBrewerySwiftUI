//
//  Identifier.swift
//  OpenBrewerySwiftUI
//
//  Created by Matthias Ludwig
//

import Foundation

struct Identifier<T, KeyType: Decodable & Hashable>: Decodable, Hashable {
    let wrappedValue: KeyType

    init(_ wrappedValue: KeyType) {
        self.wrappedValue = wrappedValue
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.wrappedValue = try container.decode(KeyType.self)
    }
}

//
//  Endpoint.swift
//  OpenBrewerySwiftUI
//
//  Created by Matthias Ludwig
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openbrewerydb.org"
        components.path = "/\(path)"

        // it adds automatically a ? sign to the uri from an empty array
        // some APIs don't like that
        if queryItems.count > 0 {
            components.queryItems = queryItems
        }

        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }

        return url
    }
}

extension Endpoint {
    static var all: Self {
        Endpoint(path: "breweries")
    }

    static func brewery(withID id: Brewery.IdentifierType) -> Self {
        Endpoint(path: "breweries/\(id.wrappedValue)")
    }

    static func search(for term: String) -> Self {
        Endpoint(path: "breweries/search", queryItems: [
            URLQueryItem(name: "query", value: term)
        ])
    }

}

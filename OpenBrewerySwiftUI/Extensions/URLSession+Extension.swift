//
//  URLSession+Extension.swift
//  OpenBrewerySwiftUI
//
//  Created by Matthias Ludwig
//

import Foundation
import Combine

extension URLSession {
    func request(endpoint: Endpoint) -> DataTaskPublisher {
        return dataTaskPublisher(for: endpoint.url)
    }
}

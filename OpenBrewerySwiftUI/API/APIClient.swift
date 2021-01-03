//
//  APIClient.swift
//  OpenBrewerySwiftUI
//
//  Created by Matthias Ludwig
//

import Foundation
import Combine

struct APIClient {
    func fetch<T: Decodable>(_ endpoint: Endpoint, using session: URLSession = .shared) -> AnyPublisher<T, Error> {
        session.request(endpoint: endpoint)
            .tryMap({ result in
                let decoder = JSONDecoder()
                guard
                    let urlResponse = result.response as? HTTPURLResponse,
                    (200...299).contains(urlResponse.statusCode)
                else {
                    let apiError = try decoder.decode(APIError.self, from: result.data)
                    throw apiError
                }

                return try decoder.decode(T.self, from: result.data)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

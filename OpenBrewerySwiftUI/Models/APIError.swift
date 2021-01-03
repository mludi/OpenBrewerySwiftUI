//
//  APIError.swift
//  OpenBrewerySwiftUI
//
//  Created by Matthias Ludwig
//

import Foundation

struct APIError: Decodable, Error {
    var message: String?
}

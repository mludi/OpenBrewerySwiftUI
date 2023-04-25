//
//  Brewery.swift
//  OpenBrewerySwiftUI
//
//  Created by Matthias Ludwig
//

import Foundation
import CoreLocation

enum BreweryType:String, Decodable {
    case micro,  brewpub, contract
    case unknown // TODO: pass any string to `unknown` case

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let breweryType = try? container.decode(String.self)

        switch breweryType {
        case "micro": self = .micro
        case "brewpub": self = .brewpub
        case "contract": self = .contract
        default: self = .unknown
        }
    }
}

struct Brewery: Decodable, Hashable {
    typealias IdentifierType = Identifier<Brewery, String>

    let id: IdentifierType
    let name: String
    let breweryType: BreweryType
    let city: String
    var street: String?
    let longitude: String?
    let latitude: String?
    var websiteUrl: String?

    var locationCoordinate: CLLocationCoordinate2D? {
        CLLocationCoordinate2D(
            latitude: Double(latitude!)!,
            longitude: Double(longitude!)!)
    }

    static let demoData = Brewery(id: IdentifierType("C73AEAC1-EA5C-4322-B4BE-3399273B7B50"), name: "Almanac Beer Company", breweryType: .micro, city: "Alameda", street: "651B W Tower Ave", longitude: "-122.306283180899", latitude: "37.7834497667258", websiteUrl: "https://almanacbeer.com")
}

extension Brewery {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case breweryType = "brewery_type"
        case city
        case street
        case longitude
        case latitude
        case websiteUrl = "website_url"
    }
}

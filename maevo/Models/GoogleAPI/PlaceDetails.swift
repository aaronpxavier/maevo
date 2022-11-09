//
//  LocationDetails.swift
//  maevo
//
//  Created by Aaron Xavier on 10/30/22.
//

import Foundation

enum AddressComponentType: String, Codable {
    case locality
    case adminAreaLevel1 = "administrative_area_level_1"
    case adminAreaLevel2 = "administrative_area_level_2"
    case adminAreaLevel3 = "administrative_area_level_3"
    case adminAreaLevel4 = "administrative_area_level_4"
    case colloquialArea = "colloquial_area"
    case postalCode = "postal_code"
    case postalTown = "postal_town"
    case postalCodePrefix = "postal_code_prefix"
    case political
    case country
    case neighborhood

}

struct AddressComponent: Codable {
    let longName: String
    let shortName: String
    let types: [AddressComponentType]
    enum CodingKeys:String, CodingKey {
        case longName = "long_name"
        case shortName = "short_name"
        case types
    }
}

struct Location: Codable {
    let lat: Double
    let lng: Double
}

struct Geometry: Codable {
    let location: Location
}

struct Place: Codable {
    let result: PlaceDetails
}

struct PlaceDetails: Codable, Identifiable {
    let id: String
    let name: String
    let geometry: Geometry
    let addressComponents: [AddressComponent]

    enum CodingKeys: String, CodingKey {
        case id = "place_id"
        case addressComponents = "address_components"
        case name
        case geometry
    }
}

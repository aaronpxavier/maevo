//
//  LocationsSearch.swift
//  maevo
//
//  Created by Aaron Xavier on 10/25/22.
//

import Foundation

struct Prediction: Codable, Identifiable, Equatable, Hashable {
    let id: String
    let description: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Prediction, rhs: Prediction) -> Bool {
        return lhs.id == rhs.id
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "place_id"
        case description
    }
}

struct Cities: Codable {
    
    
    let predictions: Array<Prediction>
    let status: String
    
}

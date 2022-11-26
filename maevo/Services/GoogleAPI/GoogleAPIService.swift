//
//  GoogleAPIService.swift
//  maevo
//
//  Created by Aaron Xavier on 10/25/22.
//

import Foundation
import Combine

class GoogleAPIService: APIBase {
    let host = "maps.googleapis.com"
    let path = "/maps/api/place"
    let apikey = APIKeys.Shared.GOOGLE_API_KEY
    var urlComps: URLComponents
    static let shared = GoogleAPIService()

    override init() {
        urlComps = URLComponents()
        urlComps.host = host
        urlComps.scheme = "https"
        urlComps.path = path
        super.init()
    }

    func fetchCityAutocomplete(_ search: String) -> AnyPublisher<Cities, Error> {
        var urlComps = self.urlComps
        urlComps.path.append("/autocomplete/json")
        let queryItems: Array<URLQueryItem> = [
            URLQueryItem(name: "input", value: search),
            URLQueryItem(name: "types", value: "locality"),
            URLQueryItem(name: "key", value: apikey)
        ]
        urlComps.queryItems = queryItems
        return getRequestAsync(urlComps: urlComps)
    }

    func fetchCityDetailsById(_ placeId: String) -> AnyPublisher<Place, Error> {
        var urlComps = self.urlComps
        urlComps.path.append("/details/json")
        let queryItems: Array<URLQueryItem> = [
            URLQueryItem(name: "place_id", value: placeId),
            URLQueryItem(name: "fields", value: "address_component,geometry,name,place_id"),
            URLQueryItem(name: "key", value: apikey)
        ]
        urlComps.queryItems = queryItems
        return getRequestAsync(urlComps: urlComps)
    }

}

//
//  WeatherAPIBase.swift
//  maevo
//
//  Created by Aaron Xavier on 10/25/22.
//

import Foundation
import Combine

class WeatherAPIService: APIBase {
    static let version = "2.5"
    let host = "api.openweathermap.org"
    let path = "/data/\(version)/weather"
    let apiKey = APIKeys.Shared.WX_API_KEY
    let units = "metric"
    var urlComps = URLComponents()
    static let shared = WeatherAPIService()
    override init() {
        urlComps.host = host
        urlComps.scheme = "https"
        urlComps.path = path

        super.init()
    }
    
    func fetchWxByPlace(_ place: Place) -> AnyPublisher<Weather, Error> {
        var urlComps = urlComps 
        let queryItems: Array<URLQueryItem> = [
            URLQueryItem(name: "lat", value: String(place.result.geometry.location.lat)),
            URLQueryItem(name: "lon", value: String(place.result.geometry.location.lng)),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: units)
        ]
        urlComps.queryItems = queryItems
        print("\nurl Comps: \(urlComps.url!)\n\n")
        return getRequestAsync(urlComps: urlComps)
    }
    
}


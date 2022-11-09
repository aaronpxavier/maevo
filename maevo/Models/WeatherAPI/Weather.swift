//
//  Weather.swift
//  maevo
//
//  Created by Aaron Xavier on 10/25/22.
//

import Foundation



struct Weather: Codable {
    let weather: Array<OverView>
    let wind: Wind
    let main: Main
}

enum WxIcon: String, Codable {
    case clearSky = "01d"
    case clearSkyNight = "01n"
    case fewClouds = "02d"
    case fewCloudsNight = "02n"
    case scatteredCloud = "03d"
    case scatteredCloudNight = "03n"
    case brknClouds = "04d"
    case brknCloudsNight = "04n"
    case showerRain = "09d"
    case showerRainNight = "09n"
    case rain = "10d"
    case rainNight = "10n"
    case tStorm = "11d"
    case tStormNight = "11n"
    case snow = "13d"
    case snowNight = "13n"
    case mist = "50d"
    case mistNight = "50n"
    
    
    func fetchSysImgName() -> String{
        switch(self) {
        case .clearSky:
            return "sun.max"
        case .clearSkyNight:
            return "moon"
        case .fewClouds:
            return "cloud.sun.fill"
        case .fewCloudsNight:
            return "cloud.moon.fill"
        case .scatteredCloud:
            return "cloud"
        case .scatteredCloudNight:
            return "cloud"
        case .brknClouds:
            return "cloud.fill"
        case .brknCloudsNight:
            return "cloud.fill"
        case .showerRain:
            return "cloud.rain.fill"
        case .showerRainNight:
            return "cloud.moon.rain.fill"
        case .rain:
            return "cloud.heavyrain"
        case .rainNight:
            return "cloud.heavyrain"
        case .tStorm:
            return "cloud.bolt.rain"
        case .tStormNight:
            return "cloud.bolt.rain"
        case .snow:
            return "cloud.snow"
        case .snowNight:
            return "cloud.snow"
        case .mist:
            return "aqi.low"
        case .mistNight:
            return "aqi.low"
        }
    }
}

struct OverView: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let main: String
    let description: String
    let icon: WxIcon
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: OverView, rhs: OverView) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?
}



struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let pressure: Double
    let humidity: Int
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case feelsLike = "feels_like"
    }
    
}

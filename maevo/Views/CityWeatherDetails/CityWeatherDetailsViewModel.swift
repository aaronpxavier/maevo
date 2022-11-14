//
//  CityWeatherDetailsViewModel.swift
//  maevo
//
//  Created by Aaron Xavier on 10/31/22.
//

import Foundation
import Combine
import SwiftUI

class CityWeatherDetailsViewModel: ObservableObject {
    let mf = MeasurementFormatter()
    @Published var place: Place? = nil
    @Published var city: String = ""
    @Published var state: String = ""
    @Published var wx: Weather? = nil
    @Published var wxIconURL: URL?
    @Published var temp: Measurement? = nil
    @Published var country: String = ""
    @Published var isLoading = true
    var gestureAnimationStartTime = Date()
    
    
    var cancellables = Set<AnyCancellable>()
    
    func fetchCityDetailsWithId(_ cityId: String) {
        GoogleAPIService.shared.fetchCityDetailsById(cityId)
            .receive(on: RunLoop.main)
            .sink {
                completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] returnedValue in
                self?.place = returnedValue
                self?.city = self?.filterAddressCompWithType(.locality) ?? ""
                self?.state = self?.filterAddressCompWithType(.adminAreaLevel1) ?? ""
                self?.country = self?.filterAddressCompWithType(.country) ?? ""
                self?.countrySpecificLogic()
                self?.loadWx()
            }
            .store(in: &cancellables)
    }
    
    private func loadWx() {
        if let place = place {
            WeatherAPIService.shared.fetchWxByPlace(place)
                .receive(on: RunLoop.main)
                .sink { [weak self]
                    completion in
                    switch completion {
                    case .finished:
                        self?.isLoading = false
                        self?.temp = Measurement(value: self?.wx?.main.temp ?? 0, unit: UnitTemperature.celsius)
                        break
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                } receiveValue: { [weak self] returnedValue in
                    
                    self?.wx = returnedValue
                    self?.wxIconURL = URL(string: "https://openweathermap.org/img/wn/\(returnedValue.weather.first!.icon)@2x.png")
                }
                .store(in: &cancellables)
        }
        
    }
    
    private func countrySpecificLogic() {
        if(country == "AE") {
            state = "UAE"
        } else if(country == "IE") {
            state = "Ireland"
        } else if(country == "GB") {
            state = "UK"
        }else if (country == "TW") {
            country = "Taiwan"
        }
        if state == "" && country != "" {
            state = country
        }
    }
    
    private  func filterAddressCompWithType(_ addressType: AddressComponentType) -> String?  {

        if let place = self.place {
            let filteredComponent = place.result.addressComponents
                .filter { addressComp in
                    for type in addressComp.types {
                        if (type == addressType) {
                            return true
                        }
                    }
                    return false
                }
                .map { $0.shortName }
                .first
            return filteredComponent
        }
        return nil
    }
    
}

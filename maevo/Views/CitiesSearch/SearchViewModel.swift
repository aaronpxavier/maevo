//
//  SearchViewModel.swift
//  maevo
//
//  Created by Aaron Xavier on 10/28/22.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var isEditing = false
    @Published var predictions: Array<Prediction> = Array<Prediction>()
    var cancellables = Set<AnyCancellable>()
    
    init()  {
        initalizeSearchTextListener()
    }
    
    private func initalizeSearchTextListener() {
        $searchText
            .filter {
                $0.count > 0
            }
            .flatMap {
            searchText in
                GoogleAPIService.shared.fetchCityAutocomplete(searchText)
        }
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
                self?.loadCities(predictions: returnedValue.predictions)
            }
            .store(in: &cancellables)
    }
    
    private func loadCities(predictions: Array<Prediction>) {
        
        let maxSize = 10
       
        var newArray = predictions
        newArray.append(contentsOf: self.predictions.filter{ !newArray.contains($0) })
        self.predictions.forEach { prediction in
            if(!newArray.contains(prediction)) {
                newArray.append(prediction)
            }
        }

        if newArray.count <= maxSize {
            self.predictions = newArray
        } else {
            self.predictions = Array(newArray[0..<(maxSize + 1)])
        }
    }
    
}

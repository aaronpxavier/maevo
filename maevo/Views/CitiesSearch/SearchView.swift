//
//  ContentView.swift
//  maevo
//
//  Created by Aaron Xavier on 10/25/22.
//

import SwiftUI
import UIKit

struct SearchView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    @State private var selection: String? = nil
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let countryList = Locale.isoRegionCodes.compactMap { Locale.current.localizedString(forRegionCode: $0) }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: SearchBar(text: $searchViewModel.searchText, isEditing: $searchViewModel.isEditing, predictions: $searchViewModel.predictions)) {
                }
                if(!searchViewModel.predictions.isEmpty) {
                    Section(header: Text("Results")) {
                        
                        ForEach(searchViewModel.predictions) {prediction in
                            NavigationLink(tag: prediction.id, selection: $selection) {
                                CityWeatherDetailsView(cityId: prediction.id)
                                    .background {
                                        Image("details_background")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .edgesIgnoringSafeArea(.all)
                                    }
                            } label: {
                                Text(prediction.description)
                                    .onTapGesture {
                                        withAnimation {
                                            searchViewModel.isEditing = false
                                            searchViewModel.searchText = ""
                                            
                                        }
                                        
                                        // Dismiss the keyboard
                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                        selection = prediction.id
                                    }
                            }
                        }
                    }
                }
                    
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Search")
            .navigationBarHidden(searchViewModel.isEditing).animation(.linear, value: 0.25)
            
            CityWeatherDetailsView(cityId: "ChIJzZFLOZZOtokRQIZEhecmIwc")
                .background {
                    Image("details_background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                }
        }
                
                
}
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchViewModel: SearchViewModel())
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

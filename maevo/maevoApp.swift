//
//  maevoApp.swift
//  maevo
//
//  Created by Aaron Xavier on 10/25/22.
//

import SwiftUI



@main
struct maevoApp: App {
    var body: some Scene {
        WindowGroup {
            SearchView(searchViewModel: SearchViewModel())
        }
    }
}

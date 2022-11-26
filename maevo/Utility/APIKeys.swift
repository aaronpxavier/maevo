//
//  Keys.swift
//  maevo
//
//  Created by Aaron Xavier on 11/25/22.
//

import Foundation

class APIKeys {
    public static let Shared = APIKeys()
    
    var keys: NSDictionary!
    public let GOOGLE_API_KEY: String
    public let WX_API_KEY: String
    
    init() {
        let path = Bundle.main.path(forResource: "keys", ofType: "plist")!
        keys = NSDictionary(contentsOfFile: path)
        GOOGLE_API_KEY = keys["GOOGLE_API_KEY"] as! String
        WX_API_KEY = keys["WX_API_KEY"] as! String
    }

    
}


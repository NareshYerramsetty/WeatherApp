//
//  Constants.swift
//  WeatherApp
//
//  Created by Naresh on 10/04/23.
//

import Foundation

struct Defaults {
    
    static var lastCity: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: "lastCityName")
        }
        get {
            UserDefaults.standard.string(forKey: "lastCityName")
        }
    }
}

struct AppConstants {
    
     static let appID = "f8812f7d7e27c384b7dd0c84800b40ac"
}

struct AppURL {
    
    static let weatherURL = "https://api.openweathermap.org/data/2.5/weather?"
    static let geoURL = "http://api.openweathermap.org/geo/1.0/direct?q="
}

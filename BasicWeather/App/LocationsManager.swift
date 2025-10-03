//
//  LocationsManager.swift
//  BasicWeather
//
//  Created by Danut Popa on 02.10.2025.
//

import Foundation

class LocationsManager {
    static let shared = LocationsManager()
    
    private init() {}
    
    private let defaults = UserDefaults.standard
    
    private var locations: [SearchLocation] = []
    
    func getLocations() -> [SearchLocation] {
        locations
    }
    
    func appendAndSave(_ location: SearchLocation) {
        locations.append(location)
        saveLocation()
    }
    
    private func saveLocation() {
        do {
            var encoded: [Data] = []
            var encoder = JSONEncoder()
            for location in locations {
                let data = try encoder.encode(location)
                encoded.append(data)
            }
            defaults.set(encoded, forKey: "Locations")
        } catch {
            print(error)
        }
    }
}

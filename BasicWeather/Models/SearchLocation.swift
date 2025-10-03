//
//  SearchLocation.swift
//  BasicWeather
//
//  Created by Danut Popa on 27.09.2025.
//

import Foundation

struct SearchLocation: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
    
    static func ==(lhs: SearchLocation, rhs: SearchLocation) -> Bool {
        return lhs.name == rhs.name && lhs.country == rhs.country && lhs.state == rhs.state && lhs.lat == rhs.lat && lhs.lon == rhs.lon
    }
}

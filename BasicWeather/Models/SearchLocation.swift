//
//  SearchLocation.swift
//  BasicWeather
//
//  Created by Danut Popa on 27.09.2025.
//

import Foundation

struct SearchLocation: Decodable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
}

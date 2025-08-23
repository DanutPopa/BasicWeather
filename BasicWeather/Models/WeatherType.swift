//
//  WeatherType.swift
//  BasicWeather
//
//  Created by Danut Popa on 13.07.2025.
//

import Foundation

enum WeatherType {
    case sunny, clear, cloudy, rainy, windy, none
    
    init(_ description: String) {
        
        switch description.lowercased() {
        case let str where str.contains("sun"):
            self = .sunny
        case let str where str.contains("clear"):
            self = .clear
        case let str where str.contains("cloud"):
            self = .cloudy
        case let str where str.contains("rain"):
            self = .rainy
        case let str where str.contains("wind"):
            self = .windy

        default:
            self = .none
        }
    }
}

//
//  WeatherType.swift
//  BasicWeather
//
//  Created by Danut Popa on 13.07.2025.
//

import UIKit

enum WeatherType {
    case sunny, clear, cloudy, snowy, foggy, misty, rainy, windy, none
    
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
    
    var icon: UIImage? {
        switch self {
        case .sunny, .clear:
            UIImage(systemName: "sun.max.fill")
        case .cloudy:
            UIImage(systemName: "cloud.fill")
        case .rainy:
            UIImage(systemName: "cloud.rain.fill")
        case .windy:
            UIImage(systemName: "wind.fill")
        case .snowy:
            UIImage(systemName: "snowflake.fill")
        case .foggy, .misty:
            UIImage(systemName: "cloud.fog.fill")
        case .none:
            nil
        }
    }
    
    var background: UIColor {
        switch self {
        case .sunny, .clear:
            return .sunnyBackground
        case .cloudy, .foggy, .misty:
            return .cloudyBackground
        case .snowy:
            return .snowyBackground
        case .rainy:
            return .rainyBackground
        case .windy:
            return .windyBackground
        case .none:
            return .white
        }
    }
    
    var tint: UIColor {
        switch self {
        case .sunny, .clear:
            return .systemYellow
        case .cloudy, .foggy, .misty:
            return .systemGray2
        case .snowy:
            return .white
        case .rainy:
            return .systemCyan
        case .windy:
            return .systemTeal
        case .none:
            return .white
        }
    }
}

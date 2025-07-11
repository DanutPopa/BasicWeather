//
//  DailyForecast.swift
//  BasicWeather
//
//  Created by Danut Popa on 23.06.2025.
//

import UIKit

struct DailyForecast {
    let day: String
    let description: String?
    var lows: [Double] = []
    var highs: [Double] = []
    var average: Double {
        return (lows.average() + highs.average()) / 2
    }
}

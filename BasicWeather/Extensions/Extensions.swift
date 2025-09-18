//
//  Extensions.swift
//  BasicWeather
//
//  Created by Danut Popa on 23.06.2025.
//

import UIKit

extension [Double] {
    func average() -> Double {
        var total: Double = 0
        var count: Double = 0
        for num in self {
            total += num
            count += 1
        }
        return total / count
    }
}

extension Int {
    func toDay() -> String {
        let date = Date(timeIntervalSince1970: Double(self))
        return date.formatted(Date.FormatStyle().weekday(.abbreviated))
    }
    
    func toHour() -> String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("h:mm")
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        
        let date = Date(timeIntervalSince1970: Double(self))
        
        return formatter.string(from: date)
    }
}

extension [WeeklyForecastList] {
     func getDailyForecasts() -> [DailyForecast] {
        var dailyForecasts: [DailyForecast] = []
        for item in self {
            guard let dt = item.dt?.toDay(),
                  let low = item.main?.tempMin,
                  let high = item.main?.tempMax
            else { continue }
                        
            guard dailyForecasts.count > 0 else {
                let newDay = parse(using: item)
                dailyForecasts.append(newDay)
                continue
            }
            
            if dailyForecasts.last?.day == dt {
                let j = dailyForecasts.count - 1
                dailyForecasts[j].lows.append(low)
                dailyForecasts[j].highs.append(high)
            } else {
                let newDay = parse(using: item)
                dailyForecasts.append(newDay)
            }
        }
        return dailyForecasts
    }
    
     func parse(using item: WeeklyForecastList) -> DailyForecast {
        var forecast = DailyForecast(
            day: item.dt?.toDay() ?? "",
            description: item.weather?.first?.main)
        
        if let tempMin = item.main?.tempMin,
           let tempMax = item.main?.tempMax {
            forecast.lows.append(tempMin)
            forecast.highs.append(tempMax)
        }

        return forecast
    }
}

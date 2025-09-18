//
//  DailyForecastCell.swift
//  BasicWeather
//
//  Created by Danut Popa on 18.06.2025.
//

import UIKit

class DailyForecastCell: UICollectionViewCell {
    
    static let id = "DailyForecastCell"
    
    @IBOutlet private weak var img: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
        
    func configure(_ item: WeeklyForecastList) {
        // img.image = UIImage()
        timeLabel.text = item.dt?.toHour()
        temperatureLabel.text = "\(item.main?.temp ?? 0)°"
        
        if let description = item.weather?.first?.main {
            let weather = WeatherType(description)
            img.image = weather.icon
        } else {
            img.image = nil
        }
    }
}

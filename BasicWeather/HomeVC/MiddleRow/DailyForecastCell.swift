//
//  DailyForecastCell.swift
//  BasicWeather
//
//  Created by Danut Popa on 18.06.2025.
//

import UIKit

class DailyForecastCell: UICollectionViewCell {
    @IBOutlet private weak var img: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    
    static let id = "DailyForecastCell"
    
    func configure() {
        
    }
}

//
//  WeeklyForecastDetailRow.swift
//  BasicWeather
//
//  Created by Danut Popa on 19.06.2025.
//

import UIKit

class WeeklyForecastDetailRow: UITableViewCell {
    static let id = "WeeklyForecastDetailRow"
    
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var img: UIImageView!
    @IBOutlet private weak var lowLabel: UILabel!
    @IBOutlet private weak var highLabel: UILabel!
    @IBOutlet private weak var slider: UISlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure() {
        
    }
}

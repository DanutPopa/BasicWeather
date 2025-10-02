//
//  LocationRow.swift
//  BasicWeather
//
//  Created by Danut Popa on 18.09.2025.
//

import UIKit

class LocationRow: UITableViewCell {
    static let searchId = "LocationRowSearchId"
    static let resultsId = "LocationRowResultsId"
    
    
    private lazy var nameLabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ location: SearchLocation) {
        if let state = location.state {
            nameLabel.text = "\(location.name), \(state), \(location.country)"
        } else {
            nameLabel.text = "\(location.name) \(location.country)"
        }
    }

}

//
//  HomeCarouselRow.swift
//  BasicWeather
//
//  Created by Danut Popa on 17.06.2025.
//

import UIKit

class HomeCarouselRow: UITableViewCell {
    static let id = "HomeCarouselRow"
    
    @IBOutlet private weak var collectionView: UICollectionView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func configure() {
        
    }

}

extension HomeCarouselRow: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyForecastCell.id, for: indexPath) as! DailyForecastCell
        return cell
    }
}

extension HomeCarouselRow: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 75, height: 140)
    }
}

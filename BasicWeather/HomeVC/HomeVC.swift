//
//  HomeVC.swift
//  BasicWeather
//
//  Created by Danut Popa on 17.06.2025.
//

import UIKit

class HomeVC: UIViewController {
    private var currentWeather: CurrentWeather?
    
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        Api.shared.fetchCurrentWeather { weather in
            guard let weather else { return }
            self.currentWeather = weather
            self.tableView.reloadData()
        }
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        switch row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTopRow.id, for: indexPath) as! HomeTopRow
            cell.configure(currentWeather)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeCarouselRow.id, for: indexPath) as! HomeCarouselRow
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeWeeklyForecastRow.id, for: indexPath) as! HomeWeeklyForecastRow
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return switch indexPath.row {
        case 0:
            250
        case 1:
            160
        case 2:
            330
        default:
            0
        }
    }
}

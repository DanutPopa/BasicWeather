//
//  HomeVC.swift
//  BasicWeather
//
//  Created by Danut Popa on 17.06.2025.
//

import UIKit

class HomeVC: UIViewController {
    private var currentWeather: CurrentWeather? {
        didSet {
            setBackgroundColor(currentWeather)
        }
    }
    private var weeklyForecast: WeeklyForecast?
    let locationsManager = LocationsManager.shared
    
    @IBOutlet private weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        if let location = locationsManager.getSelectedLocation() {
            fetchWeather(for: location)
        } else {
            let searchVC = SearchVC()
            searchVC.delegate = self
            navigationController?.pushViewController(searchVC, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setBackgroundColor(currentWeather)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        resetBackgroundColor()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func fetchWeather(for location: SearchLocation) {
        
        Api.shared.fetchWeather(lat: location.lat, lon: location.lon) { [weak self] weather, forecast in
            guard let self, let weather, let forecast else { return }
            currentWeather = weather
            weeklyForecast = forecast
            tableView.reloadData()
        }
    }
    
    @IBAction func didTapListButton(_ sender: UIBarButtonItem) {
        let searchVC = SearchVC()
        searchVC.delegate = self
        navigationController?.pushViewController(searchVC, animated: true)
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
            cell.configure(weeklyForecast)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeWeeklyForecastRow.id, for: indexPath) as! HomeWeeklyForecastRow
            cell.configure(weeklyForecast)
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

extension HomeVC: SearchVCDelegate {
    func didSelect(_ location: SearchLocation) {
        // Fetch data
        fetchWeather(for: location)
    }
}

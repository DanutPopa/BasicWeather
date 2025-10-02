//
//  Api.swift
//  BasicWeather
//
//  Created by Danut Popa on 19.06.2025.
//

import Foundation

class Api {
    static let shared = Api()
    private init() { }
    
    // MARK: - Sample data
    func fetchSample<T: Decodable>(_ type: T.Type, completion: @escaping (T?) -> Void) {
        let resource = getResourceName(type)
        guard let path = Bundle.main.path(forResource: resource, ofType: "json")
        else {
            completion(nil)
            return
        }
        let url = URL(filePath: path)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let data = try Data(contentsOf: url)
            let decodedData = try decoder.decode(type, from: data)
            completion(decodedData)
        } catch {
            print(error)
            completion(nil)
        }
    }
    
    private func getResourceName<T>(_ type: T.Type) -> String {
        switch type {
        case is CurrentWeather.Type:
            "CurrentWeather"
        case is WeeklyForecast.Type:
            "WeeklyForecast"
            case is [SearchLocation].Type:
            "SearchLocation"
        default:
            ""
        }
    }
    
    func fetchCurrentWeatherLive(completion: @escaping (CurrentWeather?) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=43.806&lon=24.101&appid=6e4a0c1183758f9ceeef911bcdc88d31&units=metric"
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil, let data
            else {
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let decodedData = try decoder.decode(CurrentWeather.self, from: data)
                completion(decodedData)
            } catch {
                print(error)
                completion(nil)
            }
        }
        task.resume()
    }
}

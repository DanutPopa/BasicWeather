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
    
    private let appId = "6e4a0c1183758f9ceeef911bcdc88d31"
    
    enum Endpoint: String {
        case currentWeather = "/data/2.5/weather"
        case weeklyForecast = "/data/2.5/forecast"
        case citySearch = "/geo/1.0/direct"
    }
    
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
    
    // MARK: Live data
    
    private func fetch<T: Decodable & Sendable>(_ type: T.Type, request: URLRequest, completion: @escaping (T?) -> Void) {
        let taks = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let data else {
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let decodedData = try decoder.decode(type, from: data)
                completion(decodedData)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
    
    private func constructURL(for endpoint: Endpoint, _ lat: Double?, _ lon: Double?, _ city: String?) -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = endpoint.rawValue
        
        switch endpoint {
        case .currentWeather, .weeklyForecast:
            guard let lat, let lon else { return nil }
            components.queryItems = [
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(lon)"),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "appid", value: appId)
            ]
        case .citySearch:
            guard let city else { return nil }
            components.queryItems = [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "limit", value: "\(5)"),
                URLQueryItem(name: "appid", value: appId)
                ]
        }
        guard let url = components.url else { return nil }
        var request = URLRequest(
            url: url,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10)
        request.httpMethod = "GET"
        return request
    }
    
    func fetchWeatherData(lat: Double, lon: Double, completion: @escaping ((CurrentWeather?, WeeklyForecast?)) -> Void) {
        // Call fetch x2 for CurrentWeather and WeeklyForecast objects
        // Construct URLRequest object x2 for the fetch function
        guard let currentWeather = constructURL(for: .currentWeather, lat, lon, nil),
              let weeklyForecast = constructURL(for: .weeklyForecast, lat, lon, nil)
        else {
            completion((nil, nil))
            return
        }
    }
    
    func fetchSearchData(city: String, completion: @escaping ([SearchLocation]?) -> Void) {
        // Construct URLRequest object x1 for the fetch function for fetching a location
        guard let search = constructURL(for: .citySearch, nil, nil, city) else {
            completion(nil)
            return
        }
    }
    
    func fetchWeather(lat: Double, lon: Double, completion: @escaping (CurrentWeather?) -> Void) {
        let urlStr = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(appId)&units=metric"
        guard let url = URL(string: urlStr) else { return }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil, let data else {
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
    
    func fetchForecast(lat: Double, lon: Double, completion: @escaping (WeeklyForecast?) -> Void) {
        let urlStr = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(appId)&units=metric"
        guard let url = URL(string: urlStr) else { return }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil, let data else {
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let decodedData = try decoder.decode(WeeklyForecast.self, from: data)
                completion(decodedData)
            } catch {
                print(error)
                completion(nil)
            }
        }
        task.resume()
    }
    
    
    
    func fetchLocation(for city: String, completion: @escaping ([SearchLocation]?) -> Void) {
        let urlString = "https://api.openweathermap.org/geo/1.0/direct?q=\(city)&limit=5&appid=\(appId)"
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
                let decodedData = try decoder.decode([SearchLocation].self, from: data)
                completion(decodedData)
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }
        task.resume()
    }
}

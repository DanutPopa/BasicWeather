//
//  WeeklyForecast.swift
//  BasicWeather
//
//  Created by Danut Popa on 20.06.2025.
//

import Foundation

struct WeeklyForecast: Decodable {
    let cod: String
    let message: Int
    let cnt: Int   // list.count
    let list: [WeeklyForecastList]?
    let city: WeeklyForecastCity?
}

struct WeeklyForecastList: Decodable {
    let dt: Int?
    let main: WeeklyForecastListMain?
    let weather: [WeeklyForecastListWeather]?
    let clouds: WeeklyForecastClouds?
    let wind: WeeklyForecastWind?
    let visibility: Int?
    let pop: Double?
    let sys: WeeklyForecastSys?
    let dtTxt: String?
}

struct WeeklyForecastListMain: Decodable {
    let temp: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let seaLevel: Int?
    let grndLevel: Int?
    let humidity: Int?
    let tempKf: Double?
}

struct WeeklyForecastListWeather: Decodable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

struct WeeklyForecastClouds: Decodable {
    let all: Int?
}

struct WeeklyForecastWind: Decodable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}

struct WeeklyForecastSys: Decodable {
    let pod: String?
}

struct WeeklyForecastCity: Decodable {
    let id: Int?
    let name: String?
    let coord: WeeklyForecastCoord?
    let country: String?
    let population: Int?
    let timezone: Int?
    let sunrise: Int?
    let sunset: Int?
}

struct WeeklyForecastCoord: Decodable {
    let lat: Double?
    let lon: Double?
}

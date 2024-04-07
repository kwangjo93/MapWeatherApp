//
//  5dayDTOs.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/7/24.
//

import Foundation

struct ForecastResponse: Codable {
    let cod: String
    let message, cnt: Int
    let list: [Lists]
    let city: City
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coordi
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coordi
struct Coordi: Codable {
    let lat, lon: Double
}

// MARK: - Lists
struct Lists: Codable {
    let dt: Int
    let main: MainClass
    let weather: [Forecasts]
    let clouds: Cloud
    let visibility: Int
    let pop: Double
    let sys: Syss
    let dtTxt: String
    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

// MARK: - Cloud
struct Cloud: Codable {
    let all: Int
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rainy
struct Rainy: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Syss
struct Syss: Codable {
    let pod: Pod
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Forecast
struct Forecasts: Codable {
    let id: Int
    let main: MainEnum
    let description, icon: String
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

extension ForecastResponse {
    func toEntity() -> ForecastEntity {
        let forcasts = self.list.map { list -> Forecast in
            let weathers = list.weather.map { weather -> Weathers in
                return Weathers(main: weather.main.rawValue,
                                description: weather.description,
                                icon: weather.icon)
            }
            return Forecast(dt: list.dt,
                           clouds: list.clouds.all,
                           pop: list.pop,
                           weather: weathers)
        }
        
        return ForecastEntity(city: self.city.name,
                              lat: self.city.coord.lat,
                              lon: self.city.coord.lon,
                              forcast: forcasts)
    }
}


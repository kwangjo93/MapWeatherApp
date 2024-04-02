//
//  DTOs.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/1/24.
//

import Foundation

struct WeatherResponse: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

struct Main: Codable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Wind: Codable {
    let speed: Double?
}

struct Clouds: Codable {
    let all: Int? // 흐림, %
}

struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

struct Rain: Codable {
    let oneHour: Double?
    let threeHours: Double?

    private enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHours = "3h"
    }
}

struct Coord: Codable {
    let lat: Double
    let lon: Double
}

extension WeatherResponse {
    func toEntity() -> WeatherEntity {
        return WeatherEntity(lat: coord.lat,
                             lon: coord.lon,
                             description: weather[0].description,
                             icon: weather[0].icon,
                             dt: dt,
                             temp: main.temp,
                             tempMin: main.tempMin,
                             tempMax: main.tempMax,
                             humidity: main.humidity,
                             cloud: clouds.all,
                             sunrise: sys.sunrise,
                             sunset: sys.sunset)
    }
}

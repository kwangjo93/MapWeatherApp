//
//  WeatherEntity.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/2/24.
//

import Foundation

struct WeatherEntity {
    let lat: Double
    let lon: Double
    let description: String
    let icon: String
    let dt: Int
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Double
    let cloud: Int?
    let sunrise: Int
    let sunset: Int
}

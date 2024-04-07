//
//  ForcastEntity.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/7/24.
//

import Foundation

struct ForecastEntity {
    let city: String
    let lat: Double
    let lon: Double
    let forcast: [Forecast]
}
struct Forecast {
    let dt: Int
    let clouds: Int
    let pop: Double
    let weather: [Weathers]
}

struct Weathers {
    let main: String
    let description: String
    let icon: String
}

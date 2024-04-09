//
//  ForcastEntity.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/7/24.
//

import Foundation

struct ForecastEntity: Identifiable {
    let id: UUID = .init()
    let city: String
    let lat: Double
    let lon: Double
    let forcast: [Forecast]
}
struct Forecast: Identifiable {
    let id: UUID = .init()
    let dt: Int
    let clouds: Int
    let pop: Double
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let main: String
    let description: String
    let icon: String
}

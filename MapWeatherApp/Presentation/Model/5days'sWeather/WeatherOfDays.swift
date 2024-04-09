//
//  WeatherOfDays.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/9/24.
//

import Foundation

struct WeatherOfDays {
    let list: [WeatherLists]
}

struct WeatherLists: Identifiable {
    let id: UUID = .init()
    let day: String
    let tempMin: Double
    let tempMax: Double
    let imageUrl: URL
}

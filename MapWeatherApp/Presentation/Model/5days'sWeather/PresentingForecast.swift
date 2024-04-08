//
//  PresentingForecast.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/7/24.
//

import Foundation

struct PresentingForecast: Identifiable  {
    let id: UUID = .init()
    let city: String
    let lat: Double
    let lon: Double
    let forcasts: [Weathers]
}

struct Weathers: Identifiable {
    let id: UUID = .init()
    let dt: Int
    let clouds: Int
    let pop: Double
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let mainText: String
    let description: String
    let imageUrl: URL
}

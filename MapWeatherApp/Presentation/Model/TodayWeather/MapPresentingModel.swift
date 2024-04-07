//
//  MapPresentingModel.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/4/24.
//

import Foundation

struct PresentingMap: Identifiable {
    var id: UUID = .init()
    let title: String
    let lat: Double
    let lon: Double
    let description: String
    let imageUrl: URL
    let dt: Int
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Double
    let cloud: Int?
    let sunrise: Int
    let sunset: Int
}

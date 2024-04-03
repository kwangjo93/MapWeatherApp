//
//  WeatherUseCase.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/2/24.
//

import Foundation

final class WeatherUseCase {
    let repository: WeatherRepository
    
    init(repository: WeatherRepository) {
        self.repository = repository
    }
    
    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherEntity? {
        let weather = await repository.fetchWeather(lat: lat, lon: lon)
        return weather
    }
}

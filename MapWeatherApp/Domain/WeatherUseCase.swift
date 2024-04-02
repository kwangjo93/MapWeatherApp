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
    
    func fetchWeather() async throws -> WeatherEntity {
        let weather = try await repository.fetchWeather()
        return weather
    }
}

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
    
    func loadUrl(imageId: String) -> URL {
        guard let imageUrl = URL(string: "https://openweathermap.org/img/wn/\(imageId)@2x.png") else { return URL(fileURLWithPath: "") }
        return imageUrl
    }
    
    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherEntity {
        let weather = try await repository.fetchWeather(lat: lat, lon: lon)
        return weather
    }
}

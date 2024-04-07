//
//  ForecastUsecase.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/7/24.
//

import Foundation

final class ForecastUsecase {
    let repository: ForecastRepository
    
    init(repository: ForecastRepository) {
        self.repository = repository
    }
    
    func loadUrl(imageId: String) -> URL {
        guard let imageUrl = URL(string: "https://openweathermap.org/img/wn/\(imageId)@2x.png") else { return URL(fileURLWithPath: "") }
        return imageUrl
    }
    
    func fetchWeather(lat: Double, lon: Double) async throws -> ForecastEntity {
        let forecast = try await repository.fetchWeather(lat: lat, lon: lon)
        return forecast
    }
}

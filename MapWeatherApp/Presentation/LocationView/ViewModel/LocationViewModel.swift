//
//  LocationViewModel.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/3/24.
//

import Foundation

final class LocationViewModel: ObservableObject {
    @Published private(set) var weather: [WeatherEntity] = []
    @Published private(set) var errorMessage: String = ""
    private let weatherUseCase: WeatherUseCase
    private let forecastUseCase: ForecastUsecase
    
    init(
        weatherUseCase: WeatherUseCase,
        forecastUseCase: ForecastUsecase
    ) {
        self.weatherUseCase = weatherUseCase
        self.forecastUseCase = forecastUseCase
    }
    
    func fetchWeather(title: String, lat: Double, lon: Double) async throws {
        do {
            let weatherEntities = try await weatherUseCase.fetchWeather(title: title, lat: lat, lon: lon)
            weather.append(weatherEntities)
        } catch {
            self.errorMessage = "ViewModel Error 발생"
            print(error)
        }
    }
}

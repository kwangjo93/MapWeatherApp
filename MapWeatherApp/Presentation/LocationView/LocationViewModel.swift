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
    
    init(weatherUseCase: WeatherUseCase) {
        self.weatherUseCase = weatherUseCase
    }
    
    func fetchWeather(lat: Double, lon: Double) async throws {
        do {
            let weatherEntities = try await weatherUseCase.fetchWeather(lat: lat, lon: lon)
            weather.append(weatherEntities)
        } catch {
            self.errorMessage = "ViewModel Error 발생"
            print(error)
        }
    }
}

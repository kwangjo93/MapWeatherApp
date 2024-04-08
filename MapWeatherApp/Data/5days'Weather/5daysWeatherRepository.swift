//
//  5daysWeatherRepository.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/7/24.
//

import Foundation

struct ForecastRepository {
    func fetchWeather(lat: Double, lon: Double) async throws -> ForecastEntity {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(Bundle.main.apiKey)&lang=kr") else {
            throw HttpError.invalidURL
        }
        let urlRequest = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let forecastResponse = try JSONDecoder().decode(ForecastResponse.self, from: data)
            return forecastResponse.toEntity()
        } catch {
            throw HttpError.jsonParseError(error)
        }
    }
    
    func mockWeather() -> ForecastEntity {
        return ForecastEntity(
            city: "인천",
            lat: 35.77,
            lon: 128.66,
            forcast: [Forecast(
                dt: 1702932,
                clouds: 0,
                pop: 1,
                temp: 16,
                tempMin: 21,
                tempMax: 55,
                main: "d",
            description: "dd",
            icon: "dd")
            ])
    }
}

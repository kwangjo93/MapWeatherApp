//
//  WeatherRepository.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/2/24.
//

import Foundation

struct WeatherRepository {
    func fetchWeather(title: String, lat: Double, lon: Double) async throws -> WeatherEntity {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Bundle.main.apiKey)&lang=kr") else {
            throw HttpError.invalidURL
        }
        let urlRequest = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
            return weatherResponse.toEntity(title: title)
        } catch {
            throw HttpError.jsonParseError(error)
        }
    }
    
    func mockWeather() -> WeatherEntity {
        return WeatherEntity(title: "",
                             lat: 35.5867229,
                             lon: 127.9095155,
                             description: "맑음",
                             icon: "1dc",
                             dt: 15,
                             temp: 24,
                             tempMin: 5,
                             tempMax: 30,
                             humidity: 23,
                             cloud: 5,
                             sunrise: 55,
                             sunset: 23)
    }
}

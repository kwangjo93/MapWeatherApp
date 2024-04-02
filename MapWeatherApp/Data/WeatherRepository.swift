//
//  WeatherRepository.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/2/24.
//

import Foundation

struct WeatherRepository {
    var fetchWeather: () async throws -> WeatherEntity
}

extension WeatherEntity {
    static let live: WeatherRepository = WeatherRepository {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(Bundle.main.apiKey)")!
        let urlRequest = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
        return weatherResponse.toEntity()
    }

    static let mock: WeatherRepository = WeatherRepository {
            WeatherEntity(lat: 35.5867229,
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

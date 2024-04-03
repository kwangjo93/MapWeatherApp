//
//  WeatherRepository.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/2/24.
//

import Foundation

struct WeatherRepository {
    func fetchWeather(lat: Double, lon: Double) async -> WeatherEntity? {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Bundle.main.apiKey)")!
        let urlRequest = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
            return weatherResponse.toEntity()
        } catch {
            print("Failed to fetch weather data with error: \(error)")
        }
        return nil
    }
    
    func mockWeather() -> WeatherEntity {
        return WeatherEntity(lat: 35.5867229,
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

/// 2개의 메서드 만들기
/// 2. 검색을 통해 얻을 하나의 api통신메서드
/// 그런 다음에 usecase에서도 파라미터에 따른 메서드 조정 (비즈니스로직)
/// ViewModel에는 USecase를 가진 다음에 그에 따른 데이터를 소유 관찰
/// 7일 일기예보에 대한 메서드

//
//  LocationViewModel.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/3/24.
//

import Foundation

final class LocationViewModel: ObservableObject {
    private let weatherUseCase: WeatherUseCase
    private let forecastUseCase: ForecastUsecase
    @Published private(set) var weather: PresentingMap?
    @Published private(set) var forecasts: [PresentingForecast] = []
    @Published private(set) var errorMessage: String = ""
    
    init(
        weatherUseCase: WeatherUseCase,
        forecastUseCase: ForecastUsecase
    ) {
        self.weatherUseCase = weatherUseCase
        self.forecastUseCase = forecastUseCase
    }
    
    @MainActor
    func fetchWeather(title: String, lat: Double, lon: Double)  {
        Task {
            do {
                let weatherEntities = try await weatherUseCase.fetchWeather(title: title, lat: lat, lon: lon)
                let presentingMap = PresentingMap(title: weatherEntities.title,
                                                  lat: weatherEntities.lat,
                                                  lon: weatherEntities.lon,
                                                  description: weatherEntities.description,
                                                  imageUrl: weatherUseCase.loadUrl(imageId: weatherEntities.icon),
                                                  dt: weatherEntities.dt,
                                                  temp: weatherEntities.temp,
                                                  tempMin: weatherEntities.tempMin,
                                                  tempMax: weatherEntities.tempMax,
                                                  humidity: weatherEntities.humidity,
                                                  cloud: weatherEntities.cloud,
                                                  sunrise: weatherEntities.sunrise,
                                                  sunset: weatherEntities.sunset)
                self.weather = presentingMap
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "ViewModel Error 발생"
                    print(error)
                }
            }
        }
    }
    
    @MainActor
    func fetchForecast(lat: Double, lon: Double)  {
        Task {
            do {
                let forecastEntities = try await forecastUseCase.fetchWeather(lat: lat, lon: lon)
                fetchWeather(title: forecastEntities.city, lat: lat, lon: lon)
                let presentingForecast = PresentingForecast(city: forecastEntities.city,
                                                            lat: forecastEntities.lat,
                                                            lon: forecastEntities.lon,
                                                            forcasts: forecastEntities.forcast.map{ weather -> Weathers in
                    return Weathers(dt: weather.dt,
                                    clouds: weather.clouds,
                                    pop: weather.pop,
                                    temp: weather.temp,
                                    tempMin: weather.tempMin,
                                    tempMax: weather.tempMax,
                                    mainText: weather.main,
                                    description: weather.description,
                                    imageUrl: weatherUseCase.loadUrl(imageId: weather.icon))
                })
                self.forecasts.append(presentingForecast)
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "ViewModel Error 발생"
                    print(error)
                }
            }
        }
    }
}

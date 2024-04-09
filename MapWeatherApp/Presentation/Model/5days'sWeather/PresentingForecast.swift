//
//  PresentingForecast.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/7/24.
//

import Foundation

struct PresentingForecast: Identifiable  {
    let id: UUID = .init()
    let city: String
    let lat: Double
    let lon: Double
    let forcasts: [Weathers]
}

struct Weathers: Identifiable {
    let id: UUID = .init()
    let dt: Int
    let clouds: Int
    let pop: Double
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let mainText: String
    let description: String
    let imageUrl: URL
}

extension PresentingForecast {
    func toWeatherDays() -> WeatherOfDays {
        let dayOrder: [String: Int] = ["월요일": 0, "화요일": 1, "수요일": 2, "목요일": 3, "금요일": 4, "토요일": 5, "일요일": 6]
        var temperaturesByDay: [String: (min: Double, max: Double, pop: Double)] = [:]
        
        for forecast in forcasts {
            let day = forecast.dt.changedTimeWithDay
            if let temperatures = temperaturesByDay[day] {
                let minTemp = min(temperatures.min, forecast.tempMin)
                let maxTemp = max(temperatures.max, forecast.tempMax)
                let pop = max(temperatures.pop, forecast.pop)
                temperaturesByDay[day] = (min: minTemp, max: maxTemp, pop: pop)
            } else {
                temperaturesByDay[day] = (min: forecast.tempMin, max: forecast.tempMax, pop: forecast.pop)
            }
        }

        var weatherLists: [WeatherLists] = []
        let sortedDays = temperaturesByDay.keys.sorted(by: { dayOrder[$0]! < dayOrder[$1]! })
        for day in sortedDays {
            guard let temperatures = temperaturesByDay[day] else { continue }
            let imageUrl = forcasts.filter {$0.dt.changedTimeWithDay == day}[0].imageUrl
            let weatherList = WeatherLists(day: day,
                                           tempMin: temperatures.min,
                                           tempMax: temperatures.max,
                                           imageUrl: imageUrl,
                                           pop: temperatures.pop)
            weatherLists.append(weatherList)
        }
        
        return WeatherOfDays(list: weatherLists)
    }
}



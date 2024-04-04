//
//  MapViewModel.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/3/24.
//

import Foundation

class MapViewModel: ObservableObject {
    @Published private(set) var regionWeather: [PresentingMap] = []
    @Published private(set) var errorMessage: String = ""
    private let weatherUseCase: WeatherUseCase
    
    private let regionLatAndLon: [RegionModel] = [
        RegionModel(title: "인천", lat: 37.469221, lon: 126.573234),
        RegionModel(title: "서울", lat: 37.540705, lon: 126.956764),
        RegionModel(title: "춘천", lat: 37.8813153, lon: 127.7299707),
        RegionModel(title: "강릉", lat: 37.751853, lon: 128.8760574),
        RegionModel(title: "아산", lat: 36.789796, lon: 127.0018494),
        RegionModel(title: "충주", lat: 36.9910113, lon: 127.9259497),
        RegionModel(title: "안동", lat: 36.5683543, lon: 128.729357),
        RegionModel(title: "태백", lat: 37.1640654, lon: 128.9855649),
        RegionModel(title: "대전", lat: 36.3504119, lon: 127.3845475),
        RegionModel(title: "전주", lat: 35.8242238, lon: 127.1479532),
        RegionModel(title: "대구", lat: 35.8714354, lon: 128.601445),
        RegionModel(title: "포항", lat: 36.0190178, lon: 129.3434808),
        RegionModel(title: "목포", lat: 34.8118351, lon: 126.3921664),
        RegionModel(title: "광주", lat: 35.1595454, lon: 126.8526012),
        RegionModel(title: "여수", lat: 34.7603737, lon: 127.6622221),
        RegionModel(title: "부산", lat: 35.1795543, lon: 129.0756416),
        RegionModel(title: "제주", lat: 33.4996213, lon: 126.5311884),
    ]
    
    init(weatherUseCase: WeatherUseCase) {
        self.weatherUseCase = weatherUseCase
    }
}

extension MapViewModel {
    @MainActor
    func fetchRegionWeather() {
        Task {
            do {
                var fetchedWeathers: [PresentingMap] = []
                for region in regionLatAndLon {
                    let weatherEntities = try await weatherUseCase.fetchWeather(title: region.title, lat: region.lat, lon: region.lon)
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
                    fetchedWeathers.append(presentingMap)
                }
                    self.regionWeather = fetchedWeathers
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "ViewModel Error 발생"
                    print(error)
                }
            }
        }
    }

}

/// 데이터 통신은 완료 됬으나 통신 후에 데이터 연결이 안된다.
/// 시간 변환 메서드

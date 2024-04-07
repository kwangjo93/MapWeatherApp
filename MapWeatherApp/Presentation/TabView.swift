//
//  TabView.swift
//  MapWeatherApp
//
//  Created by 천광조 on 3/27/24.
//

import SwiftUI

struct MainTabView: View {
    let weatherUseCase: WeatherUseCase
    let forecastUseCase: ForecastUsecase
    
    init(
        weatherUseCase: WeatherUseCase,
        forecastUseCase: ForecastUsecase
    ) {
        self.weatherUseCase = weatherUseCase
        self.forecastUseCase = forecastUseCase
    }
    
    var lcoationViewModel: LocationViewModel {
        return LocationViewModel(weatherUseCase: weatherUseCase, forecastUseCase: forecastUseCase)
    }
    
    var mapViewModel: MapViewModel {
        return MapViewModel(weatherUseCase: weatherUseCase, forecastUseCase: forecastUseCase)
    }
    
    var body: some View {
        TabView {
            MapView(viewModel: mapViewModel)
                .tabItem { Label("MapView", systemImage: "map") }
              
            LocationWeatherView(viewModel: lcoationViewModel)
                .tabItem { Label("Location", systemImage: "location") }
        }
        .tint(.black)
    }
}


#Preview {
    MainTabView(weatherUseCase: .init(repository: .init()),
                forecastUseCase: .init(repository: .init()))
}

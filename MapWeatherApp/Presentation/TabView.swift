//
//  TabView.swift
//  MapWeatherApp
//
//  Created by 천광조 on 3/27/24.
//

import SwiftUI

struct MainTabView: View {
    let useCase: WeatherUseCase
    
    init(useCase: WeatherUseCase) {
        self.useCase = useCase
    }
    
    var lcoationViewModel: LocationViewModel {
        return LocationViewModel(weatherUseCase: useCase)
    }
    
    var mapViewModel: MapViewModel {
        return MapViewModel(weatherUseCase: useCase)
    }
    
    var body: some View {
        TabView {
            MapView(viewModel: mapViewModel)
                .tabItem { Label("MapView", systemImage: "map") }
              
            LocationWeatherView(viewModel: lcoationViewModel)
                .tabItem { Label("Location", systemImage: "location") }
        }
        .tint(.yellow)
    }
}


#Preview {
    MainTabView(useCase: .init(repository: WeatherRepository()))
}

//
//  TabView.swift
//  MapWeatherApp
//
//  Created by 천광조 on 3/27/24.
//

import SwiftUI

struct MainTabView: View {
    var lcoationViewModel: LocationViewModel {
        let repository = WeatherRepository()
        let useCase = WeatherUseCase(repository: repository)
        return LocationViewModel(weatherUseCase: useCase)
    }
    
    var body: some View {
        TabView {
            MapView()
                .tabItem { Label("MapView", systemImage: "map") }
            LocationWeatherView(viewModel: lcoationViewModel)
                .tabItem { Label("Location", systemImage: "location") }
        }
        .tint(.yellow)
    }
}


#Preview {
    MainTabView()
}

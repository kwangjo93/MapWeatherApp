//
//  TabView.swift
//  MapWeatherApp
//
//  Created by 천광조 on 3/27/24.
//

import SwiftUI
import CoreLocation

struct MainTabView: View {
    let weatherUseCase: WeatherUseCase
    let forecastUseCase: ForecastUsecase
    let locationManager = CLLocationManager()
    
    @State private var userLatitude: Double = 0.0
    @State private var userLongitude: Double = 0.0
    
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
            MapView(viewModel: mapViewModel, locationManager: locationManager)
                .tabItem { Label("MapView", systemImage: "map") }
            
            LocationWeatherView(
                viewModel: lcoationViewModel,
                userLatitude: $userLatitude,
                userLongitude: $userLongitude)
                .tabItem { Label("Location", systemImage: "location") }
        }
        .onAppear {
            let locationManagerDelegate = LocationManagerDelegate(
                userLatitude: $userLatitude,
                userLongitude: $userLongitude
            )
            locationManager.delegate = locationManagerDelegate
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        .tint(.black)
    }
}

class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    @Binding var userLatitude: Double
    @Binding var userLongitude: Double
    
    init(userLatitude: Binding<Double>, userLongitude: Binding<Double>) {
        _userLatitude = userLatitude
        _userLongitude = userLongitude
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        userLatitude = userLocation.coordinate.latitude
        userLongitude = userLocation.coordinate.longitude
    }
}


#Preview {
    MainTabView(weatherUseCase: .init(repository: .init()),
                forecastUseCase: .init(repository: .init()))
}

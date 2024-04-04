//
//  ContentView.swift
//  MapWeatherApp
//
//  Created by 천광조 on 3/25/24.
//

import SwiftUI
import SwiftData
import MapKit
import Combine

struct MapView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel: MapViewModel
    @State private var defaultRegion = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35.9867229,
                                           longitude: 127.9095155),
            span: MKCoordinateSpan(latitudeDelta: 4.5,
                                   longitudeDelta: 4.5)
        ))
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Map(position: $defaultRegion) {
                ForEach(annotationItems) { annotation in
                    Annotation(coordinate: annotation.coordinate) {
                        ForEach(viewModel.regionWeather, id: \.id) { weather in
                            if weather.title == annotation.title && !viewModel.regionWeather.isEmpty {
                                WeatherImageView(weather: weather)
                                    .padding(.bottom, 25)
                            }
                        }
                    } label: { }
                }
            }
            .opacity(0.9)
            .disabled(true)
            .ignoresSafeArea()
            
            VStack {
                //날짜
            }
        }
        .onAppear {
            // 위치 묻기
        }
        .task {
            viewModel.fetchRegionWeather()
        }
    }
    
    
    @ViewBuilder
    func WeatherImageView(weather: PresentingMap) -> some View {
        
        VStack(spacing: 0) {
            AsyncImage(url: weather.imageUrl, scale: 2)
            HStack(spacing: 5) {
                Text(weather.title)
                Text("\(weather.temp.makeCelsius())°")
                    .fontWeight(.semibold)
            }
        }
        
    }
    
}

#Preview {
    MapView(viewModel: .init(weatherUseCase: .init(repository: WeatherRepository())))
}

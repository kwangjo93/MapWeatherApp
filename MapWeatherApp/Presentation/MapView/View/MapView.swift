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
            center: CLLocationCoordinate2D(latitude: 35.5867229,
                                           longitude: 127.9095155),
            span: MKCoordinateSpan(latitudeDelta: 4.4,
                                   longitudeDelta: 4.4)
        ))
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Map(position: $defaultRegion) {
                ForEach(annotationItems) { annotation in
                    Annotation("\(annotation.title)", coordinate: annotation.coordinate) {
                        ForEach(viewModel.regionWeather, id: \.id) { weather in
                            if weather.title == annotation.title && !viewModel.regionWeather.isEmpty {
                                WeatherImageView(weather: weather)
                                    .padding(.bottom, 25)
                            }
                        }
                    }
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
        VStack {
            Text("\(weather.temp)")
                .fontWeight(.semibold)
            AsyncImage(url: weather.imageUrl, scale: 1.5)
        }
    }
    
}

#Preview {
    MapView(viewModel: .init(weatherUseCase: .init(repository: WeatherRepository())))
}

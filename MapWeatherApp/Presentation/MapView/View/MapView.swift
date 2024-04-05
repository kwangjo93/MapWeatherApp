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
import CoreLocation

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
    @State var temperUnit = true
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $defaultRegion) {
                ForEach(annotationItems) { annotation in
                    Annotation(coordinate: annotation.coordinate) {
                        ForEach(viewModel.regionWeather, id: \.id) { weather in
                            if weather.title == annotation.title && !viewModel.regionWeather.isEmpty {
                                WeatherImageView(weather: weather)
                                    .padding(.bottom, 25)
                            }
                        }
                    } label: {}
                }
            }
            .opacity(0.9)
            .disabled(true)
            .ignoresSafeArea()
            HeaderView()
        }
        .onAppear {
            Task {
                await askLocationAuthorization()
            }
        }
        //        .task {
        //            viewModel.fetchRegionWeather()
        //        }
    }
    
    
    @ViewBuilder
    func WeatherImageView(weather: PresentingMap) -> some View {
        VStack(spacing: 0) {
            AsyncImage(url: weather.imageUrl, scale: 2)
            HStack(spacing: 5) {
                Text(weather.title)
                Text(temperUnit ? "\(weather.temp.makeCelsius())°" : "\(weather.temp.makeFahrenheit())°")
                    .fontWeight(.semibold)
            }
        }
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        HStack {
            Button {
                temperUnit.toggle()
            } label: {
                Text(temperUnit ? "C°" : "F°")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .foregroundStyle(temperUnit ? .blue : .red)
            }
            
            Spacer()
            LoadWeatherDate()
            Spacer()
            
            Button {
                viewModel.fetchRegionWeather()
                viewModel.isUpdating.toggle()
            } label: {
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
            }
        }
        .padding(20)
        .background {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
                    .blur(radius: 0.5)
                Divider()
            }
        }
    }
    
    @ViewBuilder
    func LoadWeatherDate() -> some View {
        if viewModel.regionWeather.isEmpty || viewModel.isUpdating {
            HStack(spacing: 15) {
                Text("날씨 불러오는 중")
                ProgressView()
                    .foregroundColor(.black)
            }
            
        } else {
            Text("\(viewModel.regionWeather[0].dt.changedTime)")
                .font(.title2)
                .fontWeight(.semibold)
        }
    }
    
    func askLocationAuthorization() async {
        let locationManager = CLLocationManager()
        let authorizationStatus = locationManager.authorizationStatus
        
        switch authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            DispatchQueue.main.async {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
}

#Preview {
    MapView(viewModel: .init(weatherUseCase: .init(repository: WeatherRepository())))
}

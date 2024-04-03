//
//  ContentView.swift
//  MapWeatherApp
//
//  Created by 천광조 on 3/25/24.
//

import SwiftUI
import SwiftData
import MapKit

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
        GeometryReader {
            let size = $0.size
            ZStack {
                VStack {
                    
                }
                
                Map(position: $defaultRegion) {
                    ForEach(annotationItems) { annotation in
                        Annotation("\(annotation.title)", coordinate: annotation.coordinate) {
                            Image(systemName: "person")
                                .font(.system(size: 35))
                            //                            WeatherImageView(imageUrl: <#T##String#>, temper: <#T##String#>)
                        }
                    }
                }
                .opacity(0.9)
                .disabled(true)
                .ignoresSafeArea()
            }
        }
        .onAppear {
            // 위치 묻기
        }
    }
    
    @ViewBuilder
    func WeatherImageView(imageUrl: String, temper: String) -> some View {
        VStack {
            Image(imageUrl)
                .font(.system(size: 35))
            Text(temper)
                .fontWeight(.semibold)
        }
    }
    
}

#Preview {
    MapView(viewModel: .init(weatherUseCase: .init(repository: WeatherRepository())))
}

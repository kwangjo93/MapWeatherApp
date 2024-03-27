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

    @State private var defaultRegion = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35.6867229,
                                           longitude: 127.9095155),
            span: MKCoordinateSpan(latitudeDelta: 4,
                                   longitudeDelta: 4)
        ))

    var body: some View {
        GeometryReader {
            let size = $0.size
            ZStack {
                Map(position: $defaultRegion)
                    .opacity(0.3)
                    .disabled(true)
                    .ignoresSafeArea()
                
                VStack(spacing: 10) {
                    HStack {
                        regionWeatherView(imageURL: "person", region: "인천", temper: 15)
                            .position(x: size.width / 7, y: size.height / 5)
                        regionWeatherView(imageURL: "person", region: "서울", temper: 15)
                            .position(x: size.width / 15, y: size.height / 6)
                        regionWeatherView(imageURL: "person", region: "춘천", temper: 15)
                            .position(x: size.width / -20, y: size.height / 10)
                        regionWeatherView(imageURL: "person", region: "강릉", temper: 15)
                            .position(x: size.width / 600, y: size.height / 8)
                    }
                    HStack {
                        regionWeatherView(imageURL: "person", region: "수원", temper: 15)
                            .position(x: size.width / 3.5, y: size.height / 20)
                        regionWeatherView(imageURL: "person", region: "청주", temper: 15)
                            .position(x: size.width / 6, y: size.height / 10)
                        regionWeatherView(imageURL: "person", region: "안동", temper: 15)
                            .position(x: size.width / 7, y: size.height / 8)
                        regionWeatherView(imageURL: "person", region: "울릉도", temper: 15)
                            .position(x: size.width / 10, y: size.height / 15)
                    }
                    HStack {
                        regionWeatherView(imageURL: "person", region: "전주", temper: 15)
                            .position(x: size.width / 4, y: size.height / 20)
                        regionWeatherView(imageURL: "person", region: "대전", temper: 15)
                            .position(x: size.width / 6, y: size.height / -100)
                        regionWeatherView(imageURL: "person", region: "대구", temper: 15)
                            .position(x: size.width / 6, y: size.height / 30)
                        regionWeatherView(imageURL: "person", region: "울산", temper: 15)
                            .position(x: size.width / 10, y: size.height / 10)
                    }
                    HStack {
                        regionWeatherView(imageURL: "person", region: "인천", temper: 15)
                            .position(x: size.width / 9, y: size.height / 80)
                        regionWeatherView(imageURL: "person", region: "서울", temper: 15)
                            .position(x: size.width / 50, y: size.height / -20)
                        regionWeatherView(imageURL: "person", region: "춘천", temper: 15)
                            .position(x: size.width / -20, y: size.height / 30)
                        regionWeatherView(imageURL: "person", region: "강릉", temper: 15)
                            .position(x: size.width / 50, y: size.height / -60)
                    }
                    
                    regionWeatherView(imageURL: "person", region: "제주", temper: 15)
                        .position(x: size.width / 5, y: size.height / -30)
                }
            }
        }
        .onAppear {
            // 위치 묻기
        }
    }
    
    @ViewBuilder
    private func regionWeatherView(imageURL: String, region: String, temper: Int) -> some View {
        VStack {
            Image(systemName: imageURL)
                .font(.system(size: 35))
            
            HStack(spacing: 5) {
                Text(region)
                    .font(.system(size: 15))
                
                Text("\(temper) ﾟ")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
            }
        }
    }
    
    
}

#Preview {
    MapView()
}

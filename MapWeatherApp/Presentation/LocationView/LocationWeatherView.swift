//
//  LocationWeatherView.swift
//  MapWeatherApp
//
//  Created by 천광조 on 3/27/24.
//

import SwiftUI

struct LocationWeatherView: View {
    @ObservedObject var viewModel: LocationViewModel
    
    init(viewModel: LocationViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        TabView {
            ForEach((0...3), id: \.self) { index in
                Text("\(index)")
//                Image(systemName: image)
//                    .resizable()
//                    .scaledToFit()
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    LocationWeatherView(
        viewModel: .init(
            weatherUseCase: .init(
                repository: WeatherRepository()
            )
        )
    )
}

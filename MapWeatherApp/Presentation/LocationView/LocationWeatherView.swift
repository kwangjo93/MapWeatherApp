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
        DetailWeatherView(addAndSearch: .add,
                          isSelect: .constant(true),
                          weather: PresentingMap(title: "광주",
                                                 lat: 33,
                                                 lon: 127,
                                                 description: "맑음",
                                                 imageUrl: URL(string: "dddd")!,
                                                 dt: 1702392,
                                                 temp: 35,
                                                 tempMin: 35,
                                                 tempMax: 12,
                                                 humidity: 24,
                                                 cloud: 4,
                                                 sunrise: 173234,
                                                 sunset: 13266)
        )
        //        TabView {
        //            ForEach((0...3), id: \.self) { index in
        //                Text("\(index)")
        //            }
        //        }
        //        .tabViewStyle(.page)
        //    }
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

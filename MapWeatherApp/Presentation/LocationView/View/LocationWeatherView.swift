//
//  LocationWeatherView.swift
//  MapWeatherApp
//
//  Created by 천광조 on 3/27/24.
//

import SwiftUI

struct LocationWeatherView: View {
    @ObservedObject var viewModel: LocationViewModel
    @Binding private var userLatitude: Double
    @Binding private var userLongitude: Double
    @State private var isSelec: Bool = false
    
    init(viewModel: LocationViewModel,
         userLatitude: Binding<Double>,
         userLongitude: Binding<Double>) {
        self.viewModel = viewModel
        _userLatitude = userLatitude
        _userLongitude = userLongitude
    }
    
    var body: some View {
        TabView {
            ForEach(viewModel.forecasts, id: \.id) { value in
                if let weather = viewModel.weather {
                    DetailWeatherView(addAndSearch: .search,
                                      isSelect: $isSelec,
                                      weather: weather,
                                      forecast: value)
                }
            }
        }
        .tabViewStyle(.page)
        .task {
            viewModel.fetchForecast(lat: userLatitude, lon: userLongitude)
        }
    }
}
    
#Preview {
    LocationWeatherView(
        viewModel: .init(
            weatherUseCase: .init(repository: WeatherRepository()), forecastUseCase: .init(repository: ForecastRepository())
    ),
        userLatitude: .constant(0),
        userLongitude: .constant(0))
}


// 배경 아이콘 색상 다시 설정하기
//didselec한 위경도를 이용해서 api통신, 그리고 api통신의 값이 변한것을 감지해서 변했다면 다음 뷰로 이동.(onchange)
// 현재 나의 위체에 대한 데이터를 만들고  [] 배열 만들어서 tabViewStyle paging
// swiftDat로 나의 위치에 대한 위 경도, 그리고 다른 데이터들의 위 경도 저장
// 저장된 위 경도에 따라 api통신 후 인스턴스 만들기

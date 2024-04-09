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
                if let weather = viewModel.weather, let weatherOfDay = viewModel.weatherOfDay {
                    DetailWeatherView(addAndSearch: .search,
                                      isSelect: $isSelec,
                                      weather: weather,
                                      forecast: value,
                                      weatherOfDays: weatherOfDay)
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


/// LocaWeatherView.paging   성공하기
// swiftDat로 나의 위치는 저장 안해도된다. 하지만 유저가 +를 통해 저장한 위 경도 값을 저장하고 , onappear을 통해 저장한 것을 불러오고 데이터 통신 후 View를 만들어 표시 -> 저장된 위 경도에 따라 api통신 후 인스턴스 만들기
//didselec한 위경도를 이용해서 api통신, 그리고 api통신의 값이 변한것을 감지해서 변했다면 다음 뷰로 이동.(onchange)

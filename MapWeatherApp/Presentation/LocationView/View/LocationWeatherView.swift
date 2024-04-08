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
        DetailWeatherView(addAndSearch: .search,
                          isSelect: .constant(false),
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
            ), forecastUseCase: .init(
                repository: ForecastRepository()
            )
        )
    )
}

// 배경 아이콘 색상 다시 설정하기
//didselec한 위경도를 이용해서 api통신, 그리고 api통신의 값이 변한것을 감지해서 변했다면 다음 뷰로 이동.(onchange)
// 현재 나의 위체에 대한 데이터를 만들고  [] 배열 만들어서 tabViewStyle paging
// swiftDat로 나의 위치에 대한 위 경도, 그리고 다른 데이터들의 위 경도 저장
// 저장된 위 경도에 따라 api통신 후 인스턴스 만들기

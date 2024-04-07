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
            ), forecastUseCase: .init(
                repository: ForecastRepository()
            )
        )
    )
}

// 서치 버튼 클릭 시 서치 화면으로 이동
// 배경 아이콘 색상 다시 설정하기
//weather 데이터를 넘겨주었다면, 위 경도만 넘겨 주어서 해당 뷰에서 api통신 후 데이터 표시.
//MapView에서 이동 시 백버튼클릭하면 값 false로 변경하기
// 현재 나의 위체에 대한 데이터를 만들고  [] 배열 만들어서 tabViewStyle paging
// swiftDat로 나의 위치에 대한 위 경도, 그리고 다른 데이터들의 위 경도 저장
// 저장된 위 경도에 따라 api통신 후 인스턴스 만들기

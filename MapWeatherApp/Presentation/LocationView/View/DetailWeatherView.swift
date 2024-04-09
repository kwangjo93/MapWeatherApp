//
//  DetailWeatherView.swift
//  MapWeatherApp
//
//  Created by 천광조 on 3/27/24.
//

import SwiftUI

struct DetailWeatherView: View {
    @State var temperUnit = true
    @State var addAndSearch: AddAndSearch
    @State var weather: PresentingMap
    @State var isSearching: Bool = false
    @Binding var isSelect: Bool
    var forecast: PresentingForecast
    var weatherOfDays: WeatherOfDays
    
    init(
        addAndSearch: AddAndSearch,
        isSelect: Binding<Bool>,
        weather: PresentingMap,
        forecast: PresentingForecast,
        weatherOfDays: WeatherOfDays
    ) {
        self.addAndSearch = addAndSearch
        _isSelect = isSelect
        self.weather = weather
        self.forecast = forecast
        self.weatherOfDays = weatherOfDays
    }
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            NavigationStack {
                ScrollView(.vertical) {
                    LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                        Section {
                            SunsetAndRiseView(weather)
                                .padding(.bottom, 8)
                            
                            Text("오늘")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(5)
                                .background(Color(.darkGray))
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal, 16)
                            
                            todaysWeathersView()
                                .padding(.bottom, 16)
                            
                            sevenDaysWeatherView(size: size)
                                .padding(.horizontal, 16)
                        } header: {
                            HeaderView(size, weather, forecast: forecast.forcasts)
                        }
                    }
                }
                .background(.gray.opacity(0.15))
            }
        }
    }
    
    @ViewBuilder
    func SunsetAndRiseView(_ weather: PresentingMap) -> some View {
        HStack(alignment: .center, spacing: 40) {
            HStack(spacing: 5) {
                Image(systemName: "sunrise.fill")
                    .font(.system(size: 25))
                    .foregroundStyle(.yellow)
                Text("\(weather.sunrise.sunriseTime)")
                    .font(.body)
                    .fontWeight(.light)
            }
            
            HStack(spacing: 5) {
                Image(systemName: "sunset")
                    .font(.system(size: 25))
                    .foregroundStyle(.orange)
                Text("\(weather.sunset.sunsetTime)")
                    .font(.body)
                    .fontWeight(.light)
            }
        }
    }
    
    @ViewBuilder
    func todaysWeathersView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .bottom, spacing: 10) {
                ForEach(forecast.forcasts, id: \.id) { forecast in
                    VStack(alignment: .center, spacing: 8) {
                        Spacer().frame(height: forecast.temp.getTempHeight() * 2)
                        
                        AsyncImage(url: forecast.imageUrl, scale: 2)
                        
                        Text(temperUnit ?
                             "\(forecast.temp.makeCelsius()) °" :
                             "\(forecast.temp.makeFahrenheit()) °")
                            .font(.headline)
                        
                        Text("\(forecast.dt.changedTime)")
                            .font(.caption)
                        Spacer().frame(height: 20)
                    }
                    .padding(8)
                    .frame(height: 120 + (forecast.temp.getTempHeight() * 2))
                    .background(Color(.darkGray))
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                    .overlay {
                        Capsule()
                            .stroke(lineWidth: 0.7)
                            .foregroundStyle(Color(.black))
                            .shadow(color: .black.opacity(0.5), radius: 5)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    func sevenDaysWeatherView(size: CGSize) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center) {
                Spacer()
                Text("최저 / 최고")
                    .font(.body)
                    .fontWeight(.semibold)
                    .padding(.top)
            }
            
            ForEach(weatherOfDays.list, id: \.id) { weather in
                DayWeatherView(weather, size: size)
                    .padding(.bottom, 5)
            }
        }
        .padding(.bottom, 16)
        .padding(.horizontal, 24)
        .background(Color(.darkGray))
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
    
    @ViewBuilder
    func DayWeatherView(_ weather: WeatherLists, size: CGSize) -> some View {
        HStack(alignment: .center) {
            Text(weather.day)
                .font(.body)
                .fontWeight(.medium)
            ZStack {
                AsyncImage(url: weather.imageUrl, scale: 2)
                    .frame(width: size.width / 2.5)
                if weather.pop != 0.0 {
                    HStack(spacing: 0) {
                        Image(systemName: "drop.fill")
                            .font(.system(size: 15))
                            .foregroundStyle(.blue)
                        Text("\(weather.pop.percentage)")
                            .font(.system(size: 15))
                    }
                    .padding(.top, 30)
                }
            }
            Text(temperUnit ?
                 "\(weather.tempMin.makeCelsius())° / \(weather.tempMax.makeCelsius())°" :
                 "\(weather.tempMin.makeFahrenheit())° / \(weather.tempMax.makeFahrenheit())°")
                .font(.title3)
                .fontWeight(.heavy)
        }
    }
    
    @ViewBuilder
    func HeaderView(_ size: CGSize, _ weather: PresentingMap, forecast: [Weathers]) -> some View {
        VStack {
            VStack(spacing: 0) {
                HStack() {
                    if isSelect {
                        Button {
                            isSelect = false
                        } label: {
                            Image(systemName: "arrowshape.backward.fill")
                                .font(.system(size: 30))
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                        }
                    }
                    
                    Button {
                        temperUnit.toggle()
                    } label: {
                        Text(temperUnit ? "°C" : "°F")
                            .font(.system(size: 30))
                            .fontWeight(.semibold)
                            .foregroundStyle(temperUnit ? .blue : .red)
                    }
                    .padding(.leading, 16)
                    
                    Spacer()
                    
                    Button(action: {
                        isSearching = true
                        print(forecast)
                    }) {
                        Image(systemName: addAndSearch == .add ? "plus" : "magnifyingglass")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 30, height: 30)
                            .background(Color.black.gradient, in: .circle)
                            .contentShape(.circle)
                    }
                    .fullScreenCover(isPresented: $isSearching) {
                        SearchBar(isSearching: $isSearching)
                    }
                }
                .padding(.horizontal, 20)
                
                Text(addAndSearch == .none ? weather.title : "dd")
                    .font(.title.bold())
            }
            
            VStack(alignment: .center, spacing: 10) {
                Text(temperUnit ? "\(weather.temp.makeCelsius())°" : "\(weather.temp.makeFahrenheit())°")
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                HStack(spacing: 30) {
                    Text(temperUnit ?
                         "최고 : \(getTempMaxValue(forecast).makeCelsius())°" :
                         "최고 : \(getTempMaxValue(forecast).makeFahrenheit())°" )
                    Text(temperUnit ?
                         "최저 : \(getTempMinValue(forecast).makeCelsius())°" :
                         "최저 : \(getTempMinValue(forecast).makeFahrenheit())°")
                }
                .font(.system(size: 20))
            }
            .padding(.top, 3)
        }
        .padding(.bottom, 10)
        .background {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(.ultraThinMaterial)
                
                Divider()
            }
            .visualEffect { content, geometryProxy in
                content
                    .opacity(headerBGOpacity(geometryProxy))
            }
            .padding(.top, -(topSafeArea.top + 15))
        }
    }
    
    func headerBGOpacity(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY + topSafeArea.top
        return CGFloat(minY > 0 ? 0 : (-minY / 15))
    }
    
    func headerScale(_ size: CGSize, proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY
        let screenHeight = size.height
        
        let progress = minY / screenHeight
        let scale = (min(max(progress, 0), 1)) * 0.6
        return 1 + scale
    }
    
    func getTempMaxValue(_ values: [Weathers]) -> Double {
        guard let firstWeather = values.first else {
               fatalError("값이 비어 있습니다.")
           }
        var maxTemp = firstWeather.tempMax
        for weather in values {
            if weather.tempMax > maxTemp {
                maxTemp = weather.tempMax
            }
        }
        return maxTemp
    }
    
    func getTempMinValue(_ values: [Weathers]) -> Double {
        guard let firstWeather = values.first else {
               fatalError("값이 비어 있습니다.")
           }
        var minTemp = firstWeather.tempMin
        for weather in values {
            if weather.tempMin < minTemp {
                minTemp = weather.tempMin
            }
        }
        return minTemp
    }
}

#Preview {
    DetailWeatherView(addAndSearch: .search,
                      isSelect: .constant(true),
                      weather: PresentingMap(title: "광주",
                                             lat: 33,
                                             lon: 127,
                                             description: "맑음",
                                             imageUrl: URL(string: "dddd")!,
                                             dt: 1702392,
                                             temp: 35,
                                             tempMin: 15,
                                             tempMax: 25,
                                             humidity: 24,
                                             cloud: 4,
                                             sunrise: 173234,
                                             sunset: 13266),
                      forecast: PresentingForecast(city: "인천",
                                                   lat: 35.77,
                                                   lon: 128.66,
                                                   forcasts: [Weathers(dt: 1702932,
                                                                       clouds: 0,
                                                                       pop: 1,
                                                                       temp: 20,
                                                                       tempMin: 15,
                                                                       tempMax: 34,
                                                                       mainText: "main",
                                                                       description: "descip",
                                                                       imageUrl: URL(string: "https://openweathermap.org/img/wn/04d@2x.png")!
                                                                      ),
                                                              Weathers(dt: 1702932,
                                                                                  clouds: 0,
                                                                                  pop: 1,
                                                                                  temp: 11,
                                                                                  tempMin: 13,
                                                                                  tempMax: 25,
                                                                                  mainText: "main",
                                                                                  description: "descip",
                                                                                  imageUrl: URL(string: "https://openweathermap.org/img/wn/04d@2x.png")!
                                                                                 ),
                                                              Weathers(dt: 1702932,
                                                                                  clouds: 0,
                                                                                  pop: 1,
                                                                                  temp: 27,
                                                                                  tempMin: 11,
                                                                                  tempMax: 34,
                                                                                  mainText: "main",
                                                                                  description: "descip",
                                                                                  imageUrl: URL(string: "https://openweathermap.org/img/wn/04d@2x.png")!
                                                                                 ),
                                                              Weathers(dt: 1702932,
                                                                                  clouds: 0,
                                                                                  pop: 1,
                                                                                  temp: 25,
                                                                                  tempMin: 18,
                                                                                  tempMax: 27,
                                                                                  mainText: "main",
                                                                                  description: "descip",
                                                                                  imageUrl: URL(string: "https://openweathermap.org/img/wn/04d@2x.png")!
                                                                                 ),
                                                              Weathers(dt: 1702932,
                                                                                  clouds: 0,
                                                                                  pop: 1,
                                                                                  temp: 20,
                                                                                  tempMin: 15,
                                                                                  tempMax: 34,
                                                                                  mainText: "main",
                                                                                  description: "descip",
                                                                                  imageUrl: URL(string: "https://openweathermap.org/img/wn/04d@2x.png")!
                                                                                 ),
                                                              Weathers(dt: 1702932,
                                                                                  clouds: 0,
                                                                                  pop: 1,
                                                                                  temp: 20,
                                                                                  tempMin: 15,
                                                                                  tempMax: 34,
                                                                                  mainText: "main",
                                                                                  description: "descip",
                                                                                  imageUrl: URL(string: "https://openweathermap.org/img/wn/04d@2x.png")!
                                                                                 ),
                                                              Weathers(dt: 1702932,
                                                                                  clouds: 0,
                                                                                  pop: 1,
                                                                                  temp: 20,
                                                                                  tempMin: 15,
                                                                                  tempMax: 34,
                                                                                  mainText: "main",
                                                                                  description: "descip",
                                                                                  imageUrl: URL(string: "https://openweathermap.org/img/wn/04d@2x.png")!
                                                                                 )
                                                   ]
                                                  ), weatherOfDays: WeatherOfDays(
                                                    list: [WeatherLists(
                                                        day: "화요일",
                                                        tempMin: 15,
                                                        tempMax: 33,
                                                        imageUrl: URL(string: "dd")!,
                                                        pop: 0
                                                    )
                                                    ]
                                                  )
    )
}

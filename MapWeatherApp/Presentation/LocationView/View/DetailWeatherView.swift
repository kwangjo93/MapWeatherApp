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
    @Binding var isSelect: Bool

    init(
        addAndSearch: AddAndSearch,
        isSelect: Binding<Bool>,
        weather: PresentingMap
    ) {
        self.addAndSearch = addAndSearch
        _isSelect = isSelect
        self.weather = weather
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
                            
                            sevenDaysWeatherView()
                                .padding(.horizontal, 16)
                        } header: {
                            HeaderView(size, weather)
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
                Text("\(weather.sunrise.sunsetTime)")
                    .font(.body)
                    .fontWeight(.light)
            }
        }
    }
    
    @ViewBuilder
    func todaysWeathersView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .bottom, spacing: 10) {
                ForEach(0...20, id: \.self) { weather in
                    VStack(alignment: .center, spacing: 8) {
                        Spacer()
                        Spacer()
                        
                        Image(systemName: "person")
                            .font(.title2)
                        
                        Text("\(weather) °")
                            .font(.headline)
                        
                        Text("15 : 00")
                            .font(.caption)
                        Spacer()
                    }
                    .padding(8)
                    .frame(height: 120 + CGFloat(weather * 5))
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
    func sevenDaysWeatherView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center) {
                Spacer()
                Text("최저 / 최고")
                    .font(.body)
                    .fontWeight(.semibold)
                    .padding(.top)
            }
            .padding(.horizontal, 25)
            
            ForEach(0...10, id: \.self) { data in
                DayWeatherView()
                    .padding(.bottom, 5)
            }
        }
        .padding(.bottom, 16)
        .background(Color(.darkGray))
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
    
    @ViewBuilder
    func DayWeatherView() -> some View {
        HStack(alignment: .center) {
            Text("오늘")
                .font(.body)
                .fontWeight(.medium)
            Spacer()
            Image(systemName: "person")
                .font(.system(size: 25))
            Spacer()
            Text("10° / 21°")
                .font(.title3)
                .fontWeight(.heavy)
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    func HeaderView(_ size: CGSize, _ weather: PresentingMap) -> some View {
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
                        print(weather)
                    } label: {
                        Text(temperUnit ? "°C" : "°F")
                            .font(.system(size: 30))
                            .fontWeight(.semibold)
                            .foregroundStyle(temperUnit ? .blue : .red)
                    }
                    .padding(.leading, 16)
                    
                    Spacer()
                    
                    NavigationLink {
                        
                    } label: {
                        Image(systemName: addAndSearch == .add ? "plus" : "magnifyingglass")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 30, height: 30)
                            .background(Color.black.gradient, in: .circle)
                            .contentShape(.circle)
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
                         "최고 : \(weather.tempMax.makeCelsius())°" :
                         "최고 : \(weather.tempMax.makeFahrenheit())°" )
                    Text(temperUnit ?
                         "최저 : \(weather.tempMin.makeCelsius())°" :
                         "최저 : \(weather.tempMin.makeFahrenheit())°")
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
}

#Preview {
    DetailWeatherView(addAndSearch: .none,
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
}

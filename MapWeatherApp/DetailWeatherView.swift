//
//  DetailWeatherView.swift
//  MapWeatherApp
//
//  Created by 천광조 on 3/27/24.
//

import SwiftUI

struct DetailWeatherView: View {
    @State var addAndSearch: AddAndSearch = .add
    @State var temperUnit = true
    var body: some View {
        GeometryReader {
            let size = $0.size
            NavigationStack {
                ScrollView(.vertical) {
                    LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                        Section {
                            
                        } header: {
                            HeaderView(size)
                        }
                    }
                    .padding(15)
                }
                .background(.gray.opacity(0.15))
            }
        }
    }
    @ViewBuilder
    func HeaderView(_ size: CGSize) -> some View {
        HStack(spacing: 10) {
            VStack {
                Button {
                    temperUnit.toggle()
                } label: {
                    Text(temperUnit ? "°C" : "°F")
                        .font(.system(size: 25))
                        .fontWeight(.semibold)
                        .foregroundStyle(temperUnit ? .blue : .red)
                }
                .padding(.leading, 8)
                
                Spacer()
            }
            
            Spacer()
            
            VStack(alignment: .center, spacing: 10) {
                Text("나의 위치")
                    .font(.title.bold())
                Text(temperUnit ? "12°" : "55°")
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                HStack(spacing: 30) {
                    Text("최고 : 20°")
                    Text("최저 : 5°")
                }
                .font(.system(size: 20))
            }
            .visualEffect { content, geometryProxy in
                content
                    .scaleEffect(headerScale(size, proxy: geometryProxy), anchor: .topLeading)
            }
            
            Spacer(minLength: 0)
            
            VStack(alignment: .leading, spacing: 5, content: {
                NavigationLink {
                    
                } label: {
                    Image(systemName: addAndSearch == .add ? "plus" : "magnifyingglass")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 25, height: 25)
                        .background(Color.gray.gradient, in: .circle)
                        .contentShape(.circle)
                }
                Spacer()
            })
            .padding(.trailing, 8)
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
    DetailWeatherView()
}

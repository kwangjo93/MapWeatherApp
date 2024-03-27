//
//  TabView.swift
//  MapWeatherApp
//
//  Created by 천광조 on 3/27/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MapView()
                .tabItem { Label("MapView", systemImage: "map") }
            Text("Hello, World!")
                .tabItem { Label("Location", systemImage: "location") }
        }
        .tint(.yellow)
    }
}


#Preview {
    MainTabView()
}

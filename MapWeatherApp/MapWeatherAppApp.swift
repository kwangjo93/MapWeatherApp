//
//  MapWeatherAppApp.swift
//  MapWeatherApp
//
//  Created by 천광조 on 3/25/24.
//

import SwiftUI
import SwiftData

@main
struct MapWeatherAppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    
    var useCase: WeatherUseCase {
        let repository = WeatherRepository()
        return WeatherUseCase(repository: repository)
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView(useCase: useCase)
        }
        .modelContainer(sharedModelContainer)
    }
}

//
//  Item.swift
//  MapWeatherApp
//
//  Created by 천광조 on 3/25/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}


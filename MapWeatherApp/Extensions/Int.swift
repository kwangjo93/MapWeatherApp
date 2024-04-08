//
//  Int.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/5/24.
//

import Foundation

extension Int {
    var changedDate: String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 M월 dd일 HH:mm"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    var sunsetTime: String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    var sunriseTime: String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    var changedTime: String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}

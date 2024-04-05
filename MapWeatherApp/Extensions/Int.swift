//
//  Int.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/5/24.
//

import Foundation

extension Int {
    var changedTime: String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 M월 dd일 HH:mm" // 날짜 형식을 원하는대로 설정하세요
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}

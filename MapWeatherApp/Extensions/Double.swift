//
//  Double.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/4/24.
//

import Foundation

extension Double {
    func makeCelsius() -> String {
        let argue = self - 273.15
        return String(format: "%.0f", arguments: [argue])
    }

    func makeFahrenheit() -> String {
        let fahrenheit = (self * 9 / 5) + 32
        return String(format: "%.0f", arguments: [fahrenheit])
    }

    func makeRounded() -> String {
        return String(format: "%.0f", self)
    }
    
    func getTempHeight() -> Double {
       return self - 273.15
    }
}


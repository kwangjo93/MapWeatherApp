//
//  String.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/9/24.
//

import SwiftUI

extension String {
    func textWithChangedColor() -> Text {
        switch self {
        case "실 비":
            return Text(self).foregroundColor(.blue)
        case "맑음":
            return Text(self).foregroundColor(.yellow)
        default:
            return Text(self).foregroundColor(.gray)
        }
    }
}



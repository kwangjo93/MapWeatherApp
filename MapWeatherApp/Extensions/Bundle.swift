//
//  Bundle.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/1/24.
//

import SwiftUI

extension Bundle {
    var apiKey: String {
        guard let file = self.path(forResource: "API_Key", ofType: "plist") else { return ""}
        guard let resource = NSDictionary(contentsOfFile: file) else { return ""}
        guard let key = resource["API_Key"] as? String else {
            fatalError("API의 값에 유효한 값을 설정해 주세요.")
        }
        return key
    }
}

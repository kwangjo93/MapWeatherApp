//
//  Error.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/4/24.
//

import Foundation

enum HttpError : Error {
    case invalidURL
    case jsonParseError(Error)
    case unknownError
}

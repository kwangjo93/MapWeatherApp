//
//  MapAnnotation.swift
//  MapWeatherApp
//
//  Created by 천광조 on 3/28/24.
//

import SwiftUI
import MapKit

struct MapAnnotation: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
    var title: String
    var temper: String?
}

 var annotationItems = [
    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.469221, longitude: 126.573234), title: "인천"),
    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.540705, longitude: 126.956764), title: "서울"),
    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.8813153, longitude: 127.7299707), title: "춘천"),
    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.751853, longitude: 128.8760574), title: "강릉"),
    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: 36.789796, longitude: 127.0018494), title: "아산"),
    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: 36.9910113, longitude: 127.9259497), title: "충주"),
    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: 36.5683543, longitude: 128.729357), title: "안동"),
    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.1640654, longitude: 128.9855649), title: "태백"),
    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: 36.3504119, longitude: 127.3845475), title: "대전"),
    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: 35.8242238, longitude: 127.1479532), title: "전주"),
    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: 35.8714354, longitude: 128.601445), title: "대구"),
    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: 36.0190178, longitude: 129.3434808), title: "포항"),
    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: 34.8118351, longitude: 126.3921664), title: "목포"),
    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: 35.1595454, longitude: 126.8526012), title: "광주"),
    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: 34.7603737, longitude: 127.6622221), title: "여수"),
    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: 35.1795543, longitude: 129.0756416), title: "부산"),
    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: 33.4996213, longitude: 126.5311884), title: "제주")
    ]

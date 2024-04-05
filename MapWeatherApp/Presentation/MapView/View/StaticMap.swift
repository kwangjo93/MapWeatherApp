//
//  StaticMap.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/5/24.
//

import SwiftUI
import MapKit

struct StaticMap: UIViewRepresentable {
    
    let mapView = MKMapView()
    @ObservedObject var viewModel: MapViewModel
    @Binding var selectedLat: Double
    @Binding var selectedLon: Double
    @Binding var isSelect: Bool
    
    func makeUIView(context: Context) -> MKMapView {
           mapView.delegate = context.coordinator
           
           let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 35.9867229,
                longitude: 127.9095155
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 4.5,
                longitudeDelta: 4.5
            )
           )
           mapView.setRegion(region, animated: true)
         mapView.isZoomEnabled = false
           return mapView
       }
       
       func updateUIView(_ uiView: MKMapView, context: Context) {
           uiView.removeAnnotations(uiView.annotations)
           for weather in viewModel.regionWeather {
               let annotation = MKPointAnnotation()
               annotation.coordinate = CLLocationCoordinate2D(
                latitude: weather.lat,
                longitude: weather.lon
               )
               uiView.addAnnotation(annotation)
           }
       }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: StaticMap
        
        init(parent: StaticMap) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let annotation = view.annotation {
                let latitude = annotation.coordinate.latitude
                let longitude = annotation.coordinate.longitude
                
                parent.selectedLat = latitude
                parent.selectedLon = longitude
                parent.isSelect = true
            }
        }
    }

}



/// Binding 위도 경도 그리고 bool 값
/// 불값이 변경되면서 위도와 경도로 네비게이션 스택을 통해 이동
/// 다시 돌아왔을 때 불 값이 다시 원래로 돌아오는 방법 생각하기 -> 똑같이 바인딩 값을 보내주고 토글시키기

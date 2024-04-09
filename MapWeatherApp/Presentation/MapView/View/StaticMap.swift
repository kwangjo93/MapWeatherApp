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
        mapView.isScrollEnabled = false
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

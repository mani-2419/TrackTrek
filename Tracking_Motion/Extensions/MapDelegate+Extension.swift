//
//  MapDelegate+Extension.swift
//  Tracking_Motion
//
//  Created by Manisha Kumari on 26/04/25.
//

import UIKit
import MapKit

protocol MapViewHandlingDelegate: MKMapViewDelegate {}

extension MapViewHandlingDelegate where Self: UIViewController {
    
    func configureMapView(_ mapView: MKMapView) {
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.isRotateEnabled = false
        mapView.pointOfInterestFilter = .excludingAll
    }

    func commonOverlayRenderer(for overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .blue
        renderer.lineWidth = 3
        renderer.lineCap = .round
        return renderer
    }
    func addStartLocationPin(coordinates: [CLLocationCoordinate2D], mapView: MKMapView) {
        if coordinates.isEmpty { return }
        
        let startPoint = MKPointAnnotation()
        startPoint.title = StringConstant.start
        if let coordinate = coordinates.first {
            startPoint.coordinate = coordinate
        }
        DispatchQueue.main.async {
            mapView.addAnnotation(startPoint)
        }
    }
    func addStartEndLocationPins(coordinates: [CLLocationCoordinate2D], mapView: MKMapView) {
        if coordinates.isEmpty { return }
        
        let startPoint = MKPointAnnotation()
        startPoint.title = StringConstant.start
        if let coordinate = coordinates.first {
            startPoint.coordinate = coordinate
        }
        DispatchQueue.main.async {
            mapView.addAnnotation(startPoint)
        }
        let endPoint = MKPointAnnotation()
        endPoint.title = StringConstant.end
        if let coordinate = coordinates.last {
            endPoint.coordinate = coordinate
        }
        DispatchQueue.main.async {
            mapView.addAnnotation(endPoint)
        }
    }
}



//
//  MapViewController.swift
//  Tracking_Motion
//
//  Created by Manisha Kumari on 25/04/25.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MapViewHandlingDelegate {
    
    @IBOutlet weak var mkMapView: MKMapView!
    var coordinates:[CLLocationCoordinate2D] = []
    var routeOverlay : MKOverlay?
    var isStopped: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView(mkMapView)
        coordinates = LocationService.shared.coordinates
        GlobalHelper.drawRoute(mkMapView: mkMapView, routeData: coordinates)
        LocationService.shared.onLocationUpdate = { [weak self] updatedCoordinates in
            guard let self = self else { return }
            self.coordinates = updatedCoordinates
            GlobalHelper.drawRoute(mkMapView: self.mkMapView, routeData: self.coordinates)
        }
        showLocationPins()
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return commonOverlayRenderer(for: overlay)
    }
    // MARK: - Show location pins according to previous screen
    func showLocationPins() {
        if (isStopped == true){
            addStartEndLocationPins(coordinates: coordinates, mapView: mkMapView)
        } else {
            addStartLocationPin(coordinates: coordinates, mapView: mkMapView)
        }
    }
}

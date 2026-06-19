//
//  GlobalHelper.swift
//  Tracking_Motion
//
//  Created by Manisha Kumari on 28/04/25.
//

import Foundation
import CoreLocation
import MapKit

class GlobalHelper {
    // MARK: - Set custom title and value on motion label
    static func showText(title: String, value: String) -> NSAttributedString {
        let string = NSMutableAttributedString()
        string.append(title.applyCustomStyle(fontSize: 18, weight: .bold, fontName: "Futura"))
        let lastText = NSAttributedString(string: "\n \(value)")
        string.append(lastText)
      return string
    }
    
    static func getDistanceInMeterKm(distance: Double) -> String {
        if (distance <= 0) {
            return StringConstant.zeroMeter
        } else if (0 < distance && distance < 1000) {
            return String(format: StringConstant.meterFormat, distance) /// Show in meters
        } else {
            let kmDistance = distance / 1000.0
            return String(format: StringConstant.kmFormat, kmDistance) /// Show in kilometers
        }
    }
    static func calculateDistanceBetweenCoordinates(_ coordinates: [CLLocationCoordinate2D]) -> String {
        
        var totalDistance: CLLocationDistance = 0.0
        
        if coordinates.count > 0 {
            for i in 0..<coordinates.count - 1 {
                let coordinate1 = CLLocation(latitude: coordinates[i].latitude, longitude: coordinates[i].longitude)
                let coordinate2 = CLLocation(latitude: coordinates[i+1].latitude, longitude: coordinates[i+1].longitude)
                totalDistance += coordinate1.distance(from: coordinate2)
            }
        }
        return GlobalHelper.getDistanceInMeterKm(distance: totalDistance)
    }
    static func drawRoute(mkMapView: MKMapView, routeData: [CLLocationCoordinate2D]) {
        if routeData.isEmpty { return }
        
        DispatchQueue.main.async {
            /// remove previous route
            mkMapView.removeOverlays(mkMapView.overlays)
            let routeOverlay = MKPolyline(coordinates: routeData, count: routeData.count)
            mkMapView.addOverlay(routeOverlay, level: .aboveRoads)
            
            let customEdgePadding = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
            mkMapView.setVisibleMapRect(routeOverlay.boundingMapRect, edgePadding: customEdgePadding, animated: true)
        }
    }
    static func setBackgroundImage(_ view: UIView ) {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
    }
}

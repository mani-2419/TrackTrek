//
//  LocationService.swift
//  Tracking_Motion
//
//  Created by Manisha Kumari on 24/04/25.
//

import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationService()
    var location = CLLocationManager()
    var coordinates: [CLLocationCoordinate2D] = []
    var onLocationUpdate: (([CLLocationCoordinate2D]) -> Void)?
    
   private override init() {
       super.init()
       location.delegate = self
       location.requestWhenInUseAuthorization()
       location.allowsBackgroundLocationUpdates = true
       location.showsBackgroundLocationIndicator = true
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print("When user did not yet determined")
        case .authorizedAlways:
            print("When user select option Allow always")
        case .authorizedWhenInUse:
            location.requestAlwaysAuthorization()
        case .denied:
            print("When user select option Dont't Allow")
        case .restricted:
            print("Restricted by parental control")
        default:
            print("Default")
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        coordinates.append(location.coordinate)
        onLocationUpdate?(coordinates)
//        print("location coordinate: \(coordinates)")
    }
    // MARK: - Use startUpdatingLocation() when you need to track the user over time, like in your walking/running app.
    ///Starts continuous tracking of the user’s location.
    func startLocation() {
        location.startUpdatingLocation()
    }
    // MARK: - Stops continuous location updates started by .startUpdatingLocation().
    func stopLocation() {
        location.stopUpdatingLocation()
    }
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            stopLocation()
            
            if let clErr = error as? CLError {
                switch clErr.code {
                case .locationUnknown, .denied, .network:
                    print("Location request failed with error: \(clErr.localizedDescription)")
                case .headingFailure:
                    print("Heading request failed with error: \(clErr.localizedDescription)")
                case .rangingUnavailable, .rangingFailure:
                    print("Ranging request failed with error: \(clErr.localizedDescription)")
                case .regionMonitoringDenied, .regionMonitoringFailure, .regionMonitoringSetupDelayed, .regionMonitoringResponseDelayed:
                    print("Region monitoring request failed with error: \(clErr.localizedDescription)")
                default:
                    print("Unknown location manager error: \(clErr.localizedDescription)")
                }
            } else {
                print("Unknown error occurred while handling location manager error: \(error.localizedDescription)")
            }
        }
    }

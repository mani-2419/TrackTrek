//
//  ViewController.swift
//  Tracking_Motion
//
//  Created by Manisha Kumari on 24/04/25.
//

import UIKit
import CoreLocation
import MapKit
import GoogleSignIn

class HomeViewController: UIViewController, MapViewHandlingDelegate {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var distanceTitle: UILabel!
    @IBOutlet weak var distanceValue: UILabel!
    @IBOutlet weak var timingLabel: UILabel!
    @IBOutlet weak var motionLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    var location: CLLocationManager?
    var coordinates:[CLLocationCoordinate2D] = []
    var timer: ActivityTimer!
    var mkMapView: MKMapView!
    var isStoppedLocation: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
        setInitialDataOnView()
        setUpMapGesture()
        GlobalHelper.setBackgroundImage(view)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer = ActivityTimer(timerLabel: timingLabel)
        LocationService.shared.onLocationUpdate = { [weak self] updatedCoordinates in
            guard let self = self else { return }
            self.coordinates = updatedCoordinates
            GlobalHelper.drawRoute(mkMapView: self.mkMapView, routeData: self.coordinates)
        }
    }
    func setInitialUI() {
        mkMapView = MKMapView(frame: self.mapView.bounds)
        mkMapView.setCornerRadius()
        mkMapView.clipsToBounds = true
        self.mapView.addSubview(mkMapView)
        mapView.setCornerRadius()
        summaryView.setCornerRadius()
        configureMapView(mkMapView)
        profileImageView.applyShadow()
        mapView.applyShadow()
        summaryView.applyShadow()
        startButton.applyShadow()
        stopButton.applyShadow()
        stopButton.isEnabled = false
        startButton.isEnabled = true
    }
    func setInitialDataOnView() {
        distanceValue.text = StringConstant.zeroKm
        timingLabel.attributedText = GlobalHelper.showText(title: StringConstant.timing, value: StringConstant.zeroTime)
        motionLabel.attributedText = GlobalHelper.showText(title: StringConstant.motion, value: StringConstant.dash)
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return commonOverlayRenderer(for: overlay)
    }
    func setUpMapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(clickOnMap))
        mapView.isUserInteractionEnabled = true
        mapView.addGestureRecognizer(gesture)
    }
    // MARK: - Map view button action
    @objc func clickOnMap() {
        let fullMapVC = MapViewController(nibName: "MapViewController", bundle: nil)
        fullMapVC.isStopped = isStoppedLocation
        navigationController?.pushViewController(fullMapVC, animated: true)
    }
    // MARK: - Start button action
    @IBAction func clickOnStart(_ sender: Any) {
        startTracking(isStarted: true)
        isStoppedLocation = false
        NotificationService.showNotification(title: "Tracking start", body: "Yeahh!!! You started your trek now.")
        timer.start()
        LocationService.shared.startLocation()
        addStartLocationPin(coordinates: coordinates, mapView: mkMapView)
        setDataOnLabel()
    }
    // MARK: - Stop button action
    @IBAction func clickOnStop(_ sender: Any) {
        startTracking(isStarted: false)
        isStoppedLocation = true
        NotificationService.showNotification(title: "Tracking stop", body: "You stop your trek")
        timer.stop()
        LocationService.shared.stopLocation()
        addStartEndLocationPins(coordinates: coordinates, mapView: mkMapView)
        setDataOnLabel()
    }
    func startTracking(isStarted: Bool) {
        if (isStarted == true) {
            startButton.isEnabled = false
            stopButton.isEnabled = true
        } else {
            startButton.isEnabled = true
            stopButton.isEnabled = false
        }
    }
    func setDataOnLabel() {
        if (coordinates.isEmpty) {
            distanceValue.text = StringConstant.zeroKm
        } else {
            let distance = GlobalHelper.calculateDistanceBetweenCoordinates(coordinates)
            distanceValue.text = distance
        }
        motionLabel.attributedText = GlobalHelper.showText(title: StringConstant.motion, value: "--")
    }
}

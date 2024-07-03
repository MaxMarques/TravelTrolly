//
//  LocationManager.swift
//  TravelTrolley
//
//  Created by Marques on 4/18/24.
//

import CoreLocation
import MapKit
import SwiftUI

class LocationManager: NSObject, ObservableObject {

    @Published var lastUserLocation: MKUserLocation?
    @Published var centerLocation: Bool = false
    @Published var trolleyRoutes: String = ""

    public let locationColor: UIColor = UIColor(.pink)
    public let routeName = ["All Routes", "North Beach Loop", "Collins Express", "Middle Beach Loop", "South Beach Loop A", "South Beach Loop B"]
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else { return }
    }
}

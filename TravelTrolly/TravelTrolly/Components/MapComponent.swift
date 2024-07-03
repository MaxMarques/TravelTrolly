//
//  MapComponent.swift
//  TravelTrolley
//
//  Created by Marques on 4/18/24.
//

import MapKit
import SwiftUI
import GoogleMaps

extension MKPointAnnotation {

    private static var IdentifierKey: UInt8 = 0
    var identifier: String? {
        get {
            return objc_getAssociatedObject(self, &MKPointAnnotation.IdentifierKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &MKPointAnnotation.IdentifierKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension MKPolyline {

    private static var IdentifierKey: UInt8 = 0
    var identifier: String? {
        get {
            return objc_getAssociatedObject(self, &MKPolyline.IdentifierKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &MKPolyline.IdentifierKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

struct MapComponent: UIViewRepresentable {

    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var trolleyRoutesApi: TrolleyRoutesApi
    @EnvironmentObject var trolleyApi: TrolleyApi
    
    func makeUIView(context: Context) -> some UIView {

        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = true
        mapView.showsUserLocation = true
        mapView.tintColor = locationManager.locationColor
        mapView.showsCompass = false
        mapView.userTrackingMode = .follow
        
        context.coordinator.mapView = mapView
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if locationManager.centerLocation == true {
            context.coordinator.centerUserLocalisation(forUserLocation: locationManager.lastUserLocation!)
            locationManager.centerLocation.toggle()
        }

        context.coordinator.updateTrolleyRoute(routeName: locationManager.trolleyRoutes)
        context.coordinator.updateTrolley(routeName: locationManager.trolleyRoutes, trolleyApi: trolleyApi)
    }
    
    func makeCoordinator() -> MapCoordinator {

        return MapCoordinator(userLocation: locationManager, trolleyRoutesApi: trolleyRoutesApi)}
    }

extension MapComponent {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        
        @Published var userLocation: LocationManager
        @Published var trolleyRoutesApi: TrolleyRoutesApi
        
        var mapView: MKMapView?
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?
        var previousTrolleyRoute: String = ""
        
        init(userLocation: LocationManager, trolleyRoutesApi: TrolleyRoutesApi) {

            self.userLocation = userLocation
            self.trolleyRoutesApi = trolleyRoutesApi
            super.init()
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            
            self.userLocation.lastUserLocation = userLocation
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

            guard !(annotation is MKUserLocation) else {
                return nil
            }
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
            
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }
            
            if let customAnnotation = annotation as? MKPointAnnotation, let identifier = customAnnotation.identifier {
                if identifier == "trolleyStops" {
                    annotationView?.image = UIImage(named: "bus-stop")
                } else if identifier == "trolley" {
                    annotationView?.image = UIImage(named: "trolley")
                }
            }
            
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

            guard let polylineOverlay = overlay as? MKPolyline else {
                return MKOverlayRenderer(overlay: overlay)
            }

            let polylineRenderer = MKPolylineRenderer(overlay: polylineOverlay)
            polylineRenderer.lineWidth = 3
            
            if let identifier = polylineOverlay.identifier, identifier == "Collins Express" {
                polylineRenderer.strokeColor = .systemOrange
            } else if let identifier = polylineOverlay.identifier, identifier == "South Beach Loop" {
                polylineRenderer.strokeColor = .systemPurple
            } else if let identifier = polylineOverlay.identifier, identifier == "Middle Beach Loop" {
                polylineRenderer.strokeColor = .systemGreen
            } else if let identifier = polylineOverlay.identifier, identifier == "North Beach Loop" {
                polylineRenderer.strokeColor = .systemBlue
            }

            return polylineRenderer
        }
        
        func updateTrolleyRoute(routeName: String) {

            if (previousTrolleyRoute != routeName) {
                previousTrolleyRoute = routeName

                switch routeName {
                case "Collins Express":
                    clearMapView()
                    addStopsAnnotation(trolleyStops: trolleyRoutesApi.CollinsExpressRoute!, annotationName: "trolleyStops")
                    drawRoute(trolleyRoute: trolleyRoutesApi.CollinsExpressRoute?.data.entry.polylines ?? [], routeName: "Collins Express")
                case "North Beach Loop":
                    clearMapView()
                    addStopsAnnotation(trolleyStops: trolleyRoutesApi.NorthBeachLoopRoute!, annotationName: "trolleyStops")
                    drawRoute(trolleyRoute: trolleyRoutesApi.NorthBeachLoopRoute?.data.entry.polylines ?? [], routeName: "North Beach Loop")
                case "Middle Beach Loop":
                    clearMapView()
                    addStopsAnnotation(trolleyStops: trolleyRoutesApi.MiddleBeachLoopRoute!, annotationName: "trolleyStops")
                    drawRoute(trolleyRoute: trolleyRoutesApi.MiddleBeachLoopRoute?.data.entry.polylines ?? [], routeName: "Middle Beach Loop")
                case "South Beach Loop A":
                    clearMapView()
                    addStopsAnnotation(trolleyStops: trolleyRoutesApi.SouthBeachLoopARoute!, annotationName: "trolleyStops")
                    drawRoute(trolleyRoute: trolleyRoutesApi.SouthBeachLoopARoute?.data.entry.polylines ?? [], routeName: "South Beach Loop")
                case "South Beach Loop B":
                    addStopsAnnotation(trolleyStops: trolleyRoutesApi.SouthBeachLoopBRoute!, annotationName: "trolleyStops")
                    drawRoute(trolleyRoute: trolleyRoutesApi.SouthBeachLoopBRoute?.data.entry.polylines ?? [], routeName: "South Beach Loop")
                case "All Routes":
                    clearMapView()
                    drawRoute(trolleyRoute: trolleyRoutesApi.CollinsExpressRoute?.data.entry.polylines ?? [], routeName: "Collins Express")
                    drawRoute(trolleyRoute: trolleyRoutesApi.NorthBeachLoopRoute?.data.entry.polylines ?? [], routeName: "North Beach Loop")
                    drawRoute(trolleyRoute: trolleyRoutesApi.MiddleBeachLoopRoute?.data.entry.polylines ?? [], routeName: "Middle Beach Loop")
                    drawRoute(trolleyRoute: trolleyRoutesApi.SouthBeachLoopARoute?.data.entry.polylines ?? [], routeName: "South Beach Loop")
                    drawRoute(trolleyRoute: trolleyRoutesApi.SouthBeachLoopBRoute?.data.entry.polylines ?? [], routeName: "South Beach Loop")
                default:
                    break
                }
            }
        }
        
        func updateTrolley(routeName: String, trolleyApi: TrolleyApi) {

            clearMapTrolleyAnnotations(withIdentifier: "trolley")

            switch routeName {
            case "Collins Express":
                addTrolleyAnnotation(trolley: trolleyApi.CollinsExpressTrolley!, annotationName: "trolley")
            case "North Beach Loop":
                addTrolleyAnnotation(trolley: trolleyApi.NorthBeachLoopTrolley!, annotationName: "trolley")
            case "Middle Beach Loop":
                addTrolleyAnnotation(trolley: trolleyApi.MiddleBeachLoopTrolley!, annotationName: "trolley")
            case "South Beach Loop A":
                addTrolleyAnnotation(trolley: trolleyApi.SouthBeachLoopATrolley!, annotationName: "trolley")
            case "South Beach Loop B":
                addTrolleyAnnotation(trolley: trolleyApi.SouthBeachLoopBTrolley!, annotationName: "trolley")
            default:
                break
            }
        }

        func addStopsAnnotation(trolleyStops: GetTrolleyRoutesModels, annotationName: String) {
            
            for stopGrouping in trolleyStops.data.entry.stopGroupings {
                for stopGroup in stopGrouping.stopGroups {
                    for stopId in stopGroup.stopIds {
                        if let stop = trolleyStops.data.references.stops.first(where: { $0.id == stopId }) {
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = CLLocationCoordinate2D(latitude: stop.lat, longitude: stop.lon)
                            annotation.title = stop.name
                            annotation.identifier = annotationName
                            mapView?.addAnnotation(annotation)
                        }
                    }
                }
            }
        }
        
        func addTrolleyAnnotation(trolley: GetTrolleyModels, annotationName: String) {
            
            for vehicleMonitoring in trolley.Siri.ServiceDelivery.VehicleMonitoringDelivery {
                for vehicleActivity in vehicleMonitoring.VehicleActivity {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: vehicleActivity.MonitoredVehicleJourney.VehicleLocation.Latitude, longitude: vehicleActivity.MonitoredVehicleJourney.VehicleLocation.Longitude)
                    annotation.title = vehicleActivity.MonitoredVehicleJourney.MonitoredCall.StopPointName
                    annotation.subtitle = "mettre un subtittle"
                    annotation.identifier = annotationName
                    mapView?.addAnnotation(annotation)
                }
            }
            
        }

        func drawRoute(trolleyRoute: [Polyline], routeName: String) {
            for polyline in trolleyRoute {
                guard let coordinates = decodePolyline(polyline.points) else { continue }
                let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
                polyline.identifier = routeName
                mapView?.addOverlay(polyline)
            }
        }
        
        func decodePolyline(_ encodedPolyline: String) -> [CLLocationCoordinate2D]? {

            guard let path = GMSPath(fromEncodedPath: encodedPolyline) else {
                return nil
            }

            var coordinates = [CLLocationCoordinate2D]()

            for i in 0..<path.count() - 1 {
                coordinates.append(path.coordinate(at: i))
            }

            return coordinates
        }
        
        func centerUserLocalisation(forUserLocation userLocation: MKUserLocation) {
            
            let coordinate = userLocation.coordinate
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            
            self.userLocationCoordinate = coordinate
            self.currentRegion = region
            
            mapView?.setRegion(region, animated: true)
        }

        func clearMapView() {

            mapView?.removeAnnotations(mapView?.annotations ?? [])
            mapView?.removeOverlays(mapView?.overlays  ?? [])
        }
        
        func clearMapTrolleyAnnotations(withIdentifier identifier: String) {

            let annotationsToRemove = mapView?.annotations.filter { annotation in
                if let customAnnotation = annotation as? MKPointAnnotation {
                    return customAnnotation.identifier == identifier
                }
                return false
            }
            mapView?.removeAnnotations(annotationsToRemove!)
        }
    }
}

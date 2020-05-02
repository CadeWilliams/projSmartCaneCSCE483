//
//  MapKitViewController.swift
//  SmartCane
//
//  Created by Shawn Popal on 3/22/20.
//  Copyright © 2020 Shawn Popal. All rights reserved.
//

import UIKit
import CoreLocation
import Speech
import MapKit

class MapKitViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var locationManager:CLLocationManager!
    let synthesizer = AVSpeechSynthesizer()
    
    var buildingLat: Double = 0.0
    var buildingLong: Double = 0.0
    

    @IBOutlet weak var mapkitView: MKMapView!
    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager = CLLocationManager()
        locationManager.delegate = self as CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
//        let utterance = AVSpeechUtterance(string: buildingNames[buildingSelector])
//        synthesizer.speak(utterance)
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
        
        
        print(buildingLat)
        print(buildingLong)
        
        mapkitView.delegate = self as MKMapViewDelegate
        mapkitView.showsScale = true
        mapkitView.showsPointsOfInterest = true
        mapkitView.showsUserLocation = true
        
        
        //let sourceLocation = locationManager.location?.coordinate
        // let buildingLats = [30.621622, 30.622970, 30.615827]
        // let buildingLongs = [-96.340082, -96.339370, -96.336934]
        
        
        let sourceLocation = CLLocationCoordinate2DMake(30.622970,-96.339370)
        let destination = CLLocationCoordinate2DMake(buildingLat, buildingLong)

//        let sourceMarker = MKPlacemark(coordinate: sourceLocation!)
        let sourceMarker = MKPlacemark(coordinate: sourceLocation)
        let destMarker = MKPlacemark(coordinate: destination)

        let sourceItem = MKMapItem(placemark: sourceMarker)
        let destItem = MKMapItem(placemark: destMarker)
        let directionsRequest = MKDirections.Request()

        directionsRequest.source = sourceItem
        directionsRequest.destination = destItem
        directionsRequest.transportType = .walking

        let directions = MKDirections(request: directionsRequest)
        directions.calculate(completionHandler: {
            response, error in
            
            
            guard let response = response else {
                if let error = error {
                    print("SOMETHING IS BAAAAADDDDD    " + error.localizedDescription)
                }
                return
            }



            let route = response.routes[0]
            self.mapkitView.addOverlay(route.polyline, level: .aboveRoads)

            let rekt = route.polyline.boundingMapRect

            self.mapkitView.setRegion(MKCoordinateRegion(rekt), animated: true)
            
            print(route.steps[0].instructions)
            
            
        })
        
        
        
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        
        return renderer
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation

//        print("user latitude = \(userLocation.coordinate.latitude)")
//        print("user longitude = \(userLocation.coordinate.longitude)")

//        labelLat.text = "\(userLocation.coordinate.latitude)"
//        labelLong.text = "\(userLocation.coordinate.longitude)"

//        let geocoder = CLGeocoder()
//        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
//            if (error != nil){
//                print("error in reverseGeocode")
//            }
//            let placemark = placemarks! as [CLPlacemark]
//            if placemark.count>0{
//                let placemark = placemarks![0]
//                print(placemark.locality!)
//                print(placemark.administrativeArea!)
//                print(placemark.country!)
//
//                self.labelAdd.text = "\(placemark.locality!), \(placemark.administrativeArea!), \(placemark.country!)"
//            }
//        }

    }
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Error \(error)")
//    }
    
    
}



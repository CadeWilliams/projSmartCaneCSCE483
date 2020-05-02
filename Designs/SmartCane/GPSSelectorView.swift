//
//  ViewController.swift
//  SmartCane
//
//  Created by Shawn Popal on 3/10/20.
//  Copyright © 2020 Shawn Popal. All rights reserved.
//

import UIKit
import CoreLocation
import Speech
import MapKit

class GPSSelectorView: UIViewController, CLLocationManagerDelegate {

    var locationManager:CLLocationManager!
    
    let synthesizer = AVSpeechSynthesizer()
    
    
    @IBOutlet weak var denyButton: UIButton!
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var buildingImage: UIImageView!
    @IBOutlet weak var viewContainer: UIView!
    
    
    var buildingSelector = 0
    let buildingNames = ["Zachry Engineering Center",
                         "Emerging Technologies Building",
                         "Engineering Activities Building A"]
    
    let buildingLats = [30.621622, 30.622970, 30.615827]
    let buildingLongs = [-96.340082, -96.339370, -96.336934]
    let buildingImages = ["Zachry Buildiing.jpg",
                          "ETB.jpg", "EABA.jpeg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager = CLLocationManager()
        locationManager.delegate = self as CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        testLabel.text = buildingNames[buildingSelector]
        buildingImage.image = UIImage(named: buildingImages[buildingSelector])
        viewContainer.layer.cornerRadius = 20
        
        let utterance = AVSpeechUtterance(string: buildingNames[buildingSelector])
        synthesizer.speak(utterance)
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
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
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }

    @IBAction func nextOption(_ sender: Any) {
        
        if buildingSelector < buildingNames.count-1 {
            buildingSelector += 1
        } else {
            buildingSelector = 0
        }
        
        let utterance = AVSpeechUtterance(string: buildingNames[buildingSelector])
        synthesizer.speak(utterance)
        testLabel.text = buildingNames[buildingSelector]
        buildingImage.image = UIImage(named: buildingImages[buildingSelector])
    }
    @IBAction func selectOption(_ sender: Any) {
//        print("performing segue")
//        performSegue(withIdentifier: "mapkitSegue", sender: Any?.self)
//        print("going")
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!))
        {
            UIApplication.shared.openURL(NSURL(string:
            "comgooglemaps://?saddr=&daddr=\(Float(buildingLats[buildingSelector])),\(Float(buildingLongs[buildingSelector]))&directionsmode=walking")! as URL)
        } else
        {
            NSLog("Can't use com.google.maps://");
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        print("getting vc")
        let vc = segue.destination as! MapKitViewController
        
        print("setting vars")
        vc.buildingLat = buildingLats[buildingSelector]
        vc.buildingLong = buildingLongs[buildingSelector]
    }
        
    
}


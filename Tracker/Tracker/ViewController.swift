//
//  ViewController.swift
//  Tracker
//
//  Created by Hoff Silva on 27/01/17.
//  Copyright © 2017 Hoff Silva. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
   
    
    @IBOutlet weak var distanceLabel: UILabel!
    var locationManagerr = CLLocationManager()
    var locations = [CLLocationManager]()
    var distance = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManagerr.requestAlwaysAuthorization()
      
        // Do any additional setup after loading the view, typically from a nib.
       
    }
    @IBAction func stopUpdateLocation(_ sender: Any) {
        
        locationManagerr.stopUpdatingLocation()
        distanceLabel.text = String(distance)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startTrack(_ sender: Any) {
        startLocationUpdates()
    }
    
    func startLocationUpdates(){
        if !CLLocationManager.locationServicesEnabled(){
            print("Erro!")
        }else{
           self.locationManagerr.delegate = self
            self.locationManagerr.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManagerr.activityType = CLActivityType.automotiveNavigation
            self.locationManagerr.distanceFilter = 10
            self.locationManagerr.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        var locationsT = locations
        
        for location in locationsT{
            if location.horizontalAccuracy < 20 {
                if locations.count > 0 {
                    self.distance += location.distance(from: locationsT.last!)
                }
                locationsT.append(location)
            }
            
        }
       // print(locationsT)
        
        print(distance)
        distanceLabel.text = String(distance)
    }
    
    
    

}


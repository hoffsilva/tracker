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
   
    @IBOutlet weak var pause: UIButton!
    
    @IBOutlet weak var distanceLabel: UILabel!
    var locationManagerr = CLLocationManager()
    var locationsCaptureds = [CLLocation]()
    
    var currentLocation:CLLocation!
    var lastLocation: CLLocation!
    var traveledDistance:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManagerr.requestAlwaysAuthorization()
        
      
        // Do any additional setup after loading the view, typically from a nib.
       
    }
    @IBAction func stopUpdateLocation(_ sender: Any) {
        
        locationManagerr.stopUpdatingLocation()
        view.backgroundColor = UIColor.white

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
        
        UIView.animate(withDuration: 1
            , animations: { 
                self.view.backgroundColor = UIColor.green.withAlphaComponent(0.6)
        }) { (finished) in
            UIView.animate(withDuration: 1) {
                self.view.backgroundColor = UIColor.green.withAlphaComponent(0.8)
            }
        }
        
        if currentLocation == nil {
            currentLocation = locations.first
        } else {
            if let lastLocation = locations.last {
                let distance = currentLocation.distance(from: self.lastLocation)
                let lastDistance = lastLocation.distance(from: self.lastLocation)
                traveledDistance += lastDistance
                print( "\(currentLocation)")
                print( "\(lastLocation)")
                print("FULL DISTANCE: \(traveledDistance)")
                print("STRAIGHT DISTANCE: \(distance)")
            }
        }
        lastLocation = locations.last
        distanceLabel.text = String(traveledDistance/1000)
        
        
    }
    
    
    
    

}


//
//  ViewController.swift
//  MapKit Playground
//
//  Created by Taylor Schmidt on 2/9/16.
//  Copyright © 2016 Taylor Schmidt. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    let regionRadius: CLLocationDistance = 1000

    override func viewDidLoad() {
        super.viewDidLoad()
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(initialLocation)
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    /// Asynchronous performs the data query then updates the UI
    func refresh (sender: AnyObject!) {
        
        let client = SODAClient(domain: "data.texas.gov", token: "MjjJch7lycnAbC0Oqlgbh6190")
        let cngQuery = client.queryDataset("9e7h-gz56").filterColumn("route", "642")
        /*
        this is from:
        https://data.texas.gov/Capital-Metro/Capital-Metro-VehicleLocation/9e7h-gz56
        
        problem:
        we want to use:
        https://data.texas.gov/Capital-Metro/Vehicle-Positions-JSON-File/cuc7-ywmd
        but I can't get it to return anything
        */
        
        
        cngQuery.get { res in
            switch res {
            case .Dataset (let data):
                // Update our data
                if let location = data[0]["location"] {
                    print(location)
                }
            case .Error (let err):
                print("Error refreshing")
                print(err.userInfo.debugDescription)
            }
            
        }
    }
}


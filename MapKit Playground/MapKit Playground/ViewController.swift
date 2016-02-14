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
    
    
    /*
    
    Julio and Micah,
    
    Spend some time Sunday trying to figure out how all the below works. I had to sign up
    for the token below, so don't worry about that, it's just so they know who's
    getting their data. The part with '9e7h-gz56' is the last bit of the URL for the
    page on the Texas open data website that I could get to work with this framework.
    If you want to try other ones you have to find their relevant string. 
    
    You can look inside SODAClient.swift to see what it does, but the examples online 
    of how to use it are probably more useful.
    
    In terms of Sunday and beyond (feel free to make any changes you want):
    1) If you could look into MapKit a bit and figure out how to get icons (I believe
    they're referred to as 'annotations' in the iOS world) to show up on the map given
    certain data that would probably be a good first step.
    2) Figure out how to store and then how to show routes/paths on a map. I believe in iOS
    land these are called "Map overlays"
    3) Getting ahold of the user's location and then showing that location on the map would
    also be useful. Then you can just replace the coordinates above with those to have it start
    the map out over the user's coordinates.

    4) I imagine this is farther than you guys will get but after we've got those things done and
    we have the "all bus routes" screen working and showing all the routes we can get to work on
    all the menus for how to narrow down what we want to look at. In other words the route
    selector and the bus selector.

    I think that's a long enough list of things for now at least. Again, if there's anything you
    think we should change in terms of planning feel free to and I'll see it in the git diff.
    
    - Taylor
    
    */
    // Performs data query and outputs to console.
    func refresh (sender: AnyObject!) {
        
        let client = SODAClient(domain: "data.texas.gov", token: "MjjJch7lycnAbC0Oqlgbh6190")
        let cngQuery = client.queryDataset("9e7h-gz56").filterColumn("route", "642")
        /*
        this is from:
        https://data.texas.gov/Capital-Metro/Capital-Metro-VehicleLocation/9e7h-gz56
        
        problem:
        we want to use this since it's the one from McNiff:
        https://data.texas.gov/Capital-Metro/Vehicle-Positions-JSON-File/cuc7-ywmd
        but I can't get it to return anything but an empty array
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


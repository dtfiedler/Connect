//
//  NearbyPlacesViewController.swift
//  Connect
//
//  Created by Dylan Fiedler on 1/21/16.
//  Copyright © 2016 xor. All rights reserved.
//

import UIKit
import GoogleMaps

class NearbyPlacesViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapCenterPinImage: UIImageView!
    let locationManager = CLLocationManager()
    var placePicker: GMSPlacePicker?
    
     var searchedTypes = ["bakery", "bar", "cafe", "grocery_or_supermarket", "restaurant"]
    
    let dataProvider = GoogleDataProvider()
    let searchRadius: Double = 5000
    let pink = UIColor(red: 242/255, green: 87/255, blue: 100/255, alpha: 1)
    let teal = UIColor(red: 4/255, green: 217/255, blue: 196/255, alpha: 1)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refresh")
        refresh.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = refresh
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        mapView.delegate = self
        mapView.myLocationEnabled = true
        
        self.navigationItem.title = "Places Nearby"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(){
        mapView.clear()
        self.fetchNearbyPlaces(mapView.myLocation.coordinate)
        
    }
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
       
        //self.fetchNearbyPlaces(mapView.myLocation.coordinate)

        // 1
        let geocoder = GMSGeocoder()
        
        // 2
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                
                // 3
                let lines = address.lines as! [String]
                self.addressLabel.text = lines.joinWithSeparator("\n")
                
                // 4
                UIView.animateWithDuration(0.0) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }

    func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
        
        dataProvider.fetchPlacesNearCoordinate(mapView.myLocation.coordinate, radius:searchRadius, types: searchedTypes) { places in
            for place: GooglePlace in places {
                // 3
                
                let marker = PlaceMarker(place: place)
                // 4
                marker.map = self.mapView
            }
        }
    }

}

extension NearbyPlacesViewController: CLLocationManagerDelegate {
    // 2
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // 3
        if status == .AuthorizedWhenInUse {
            
            // 4
            locationManager.startUpdatingLocation()
            
            //5
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    // 6
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            // 7
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            // 8
            locationManager.stopUpdatingLocation()
            
            fetchNearbyPlaces(location.coordinate)
        }
        
    }
}

extension NearbyPlacesViewController: GMSMapViewDelegate {
    func mapView(mapView: GMSMapView!, idleAtCameraPosition position: GMSCameraPosition!) {
        reverseGeocodeCoordinate(position.target)
        
        //Add this line
        self.addressLabel.hidden = false
    }
    
    func mapView(mapView: GMSMapView!, willMove gesture: Bool) {
        addressLabel.hidden = false
    }
    
    func mapView(mapView: GMSMapView!, markerInfoContents marker: GMSMarker!) -> UIView! {
        // 1
        let placeMarker = marker as! PlaceMarker
        
        // 2
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "MarkerInfoView", bundle: bundle)
        let infoView = nib.instantiateWithOwner(self, options: nil)[0] as! MarkerInfoView
        
        infoView.nameLabel.text = placeMarker.place.name
            
            // 4
            if let photo = placeMarker.place.photo {
                infoView.placePhoto.image = photo
            } else {
                infoView.placePhoto.image = UIImage(named: "generic")
            }
            
        return infoView
        
    }
    
    func mapView(mapView: GMSMapView!, didTapMarker marker: GMSMarker!) -> Bool {
        //mapView.selectedMarker = marker
        UIView.animateWithDuration(0.25, animations: {
            self.mapCenterPinImage.alpha = 0
        })
        return false
    }

}
//
//  NearbyPlacesViewController.swift
//  Connect
//
//  Created by Dylan Fiedler on 1/21/16.
//  Copyright © 2016 xor. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class NearbyPlacesViewController: UIViewController, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapCenterPinImage: UIImageView!
    let locationManager = CLLocationManager()
    var placePicker: GMSPlacePicker?
    var directions:  [String: JSON]?
     var searchedTypes = ["bakery", "bar", "cafe", "grocery_or_supermarket", "restaurant"]
    
    let dataProvider = GoogleDataProvider()
    let searchRadius: Double = 5000
    let pink = UIColor(red: 242/255, green: 87/255, blue: 100/255, alpha: 1)
    let teal = UIColor(red: 4/255, green: 217/255, blue: 196/255, alpha: 1)
    let orange = UIColor(red: 255/255, green: 152/255, blue: 33/255, alpha: 1.0)
    var currentMarker: GMSMarker?
    var polyLine: GMSPolyline!
    var steps: [NSString]!
    let grayTextColor = UIColor(red: 59/255, green: 59/255, blue: 63/255, alpha: 1.0)
    var table = UITableView()
    var strings: [NSString] = []
    let greenColor = UIColor(red: 70/255, green: 173/255, blue: 0/255, alpha: 1.0)
    let backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
    var mode = "Driving"
    var selectIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refresh = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refresh")
        refresh.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = refresh
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        addressLabel.hidden = true
        addressLabel.alpha = 0

        mapView.delegate = self
        mapView.myLocationEnabled = true
        
        self.navigationItem.title = "Places Nearby"

        table.backgroundColor = backgroundColor
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
       
        // 1
        let geocoder = GMSGeocoder()
        
        // 2
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                
                // 3
                let lines = address.lines as! [String]
                //self.addressLabel.text = lines.joinWithSeparator("\n")
                
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
        
        UIView.animateWithDuration(0.5, animations: {
            self.table.frame = CGRect(x: 0, y: self.view.frame.height, width: self.table.frame.width, height: self.table.frame.height)
        })
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
        UIView.animateWithDuration(0.5, animations: {
            self.table.frame = CGRect(x: 0, y: self.view.frame.height, width: self.table.frame.width, height: self.table.frame.height)
        })
    }
    
    func mapView(mapView: GMSMapView!, markerInfoContents marker: GMSMarker!) -> UIView! {
        // 1
        let placeMarker = marker as! PlaceMarker
        
        // 2
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "MarkerInfoView", bundle: bundle)
        let infoView = nib.instantiateWithOwner(self, options: nil)[0] as! MarkerInfoView
        
        infoView.nameLabel.text = placeMarker.place.name
        
        infoView.coordinates = placeMarker.position
        
        infoView.placePhoto.tintColor =  UIColor.lightGrayColor()
        
        addressLabel.text = "Get directions (tap here)"
        
        return infoView
        
    }
    
    func mapView(mapView: GMSMapView!, didCloseInfoWindowOfMarker marker: GMSMarker!) {
        UIView.animateWithDuration(0.5, animations: {
            self.table.frame = CGRect(x: 0, y: self.view.frame.height, width: self.table.frame.width, height: self.table.frame.height)
        })
    }
    
    func mapView(mapView: GMSMapView!, didTapMarker marker: GMSMarker!) -> Bool {
        currentMarker = marker
        //mapView.selectedMarker = marker
        UIView.animateWithDuration(0.25, animations: {
            self.mapCenterPinImage.alpha = 0
        })
        
        getDirections()
        return false
    }
    
    func getDirections(){
        
        let origin = mapView.myLocation.coordinate
        let destination = currentMarker?.position
        let destinationString = "\(destination!.latitude),\(destination!.longitude)"
        let originString = "\(origin.latitude),\(origin.longitude)"
        let url = "https://maps.googleapis.com/maps/api/directions/json"

        Alamofire.request(.GET, url, parameters: ["origin": originString, "destination": destinationString, "mode" : mode.lowercaseString, "key": "AIzaSyAaVC1_FoBkiEyRA9DDj1FD0tl97o-Ywp4", "sensor" : "true" ], headers: nil)
            .responseJSON { response in
                switch response.result {
                    
                case .Success(let data):
                    
                    let json = JSON(data)
                    //print(json)
                    
                    let errornum = json["error"]
                    
                    
                    if (errornum == true){
                        
                    }else{
                        let routes = json["routes"].array
                        
                        let directions2 = json["routes"][0].dictionary//as? [[String: AnyObject]]
                        self.directions = directions2
                        if routes != nil{
                            
                            let overViewPolyLine = routes![0]["overview_polyline"]["points"].string
                            //self.steps = routes![0]["legs"]
                            if overViewPolyLine != nil{
                                
                                self.addPolyLineWithEncodedStringInMap(overViewPolyLine!)
                                self.createDirectionsTable()
                                
                            }
                            
                        }
                        
                    }
                    
                case .Failure(let error):
                    
                    print("Request failed with error: \(error)")
                    
                }
        }
    }
    
    func addPolyLineWithEncodedStringInMap(encodedString: String) {
    
        if (polyLine != nil){polyLine.map = nil}
            let path = GMSMutablePath(fromEncodedPath: encodedString)
            polyLine = GMSPolyline(path: path)
            polyLine!.strokeWidth = 7
            polyLine!.strokeColor = UIColor.orangeColor()
            polyLine.map = self.mapView
    }
    
    func createTable(){
        table.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height * 0.3 + 5)
        table.delegate = self
        table.dataSource = self
        table.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func createDirectionsTable(){
       // mapView.camera = GMSCameraPosition.cameraWithTarget((currentMarker?.position)!, zoom: 20)

        if (strings.count == 0 ){
            createTable()
        }
       strings.removeAll()
       let stepCount = directions!["legs"]![0]["steps"].array?.count
       for i in 0...stepCount! - 1 {
        for (key, value) in directions!["legs"]![0]["steps"][i].dictionary!{
            if key == "html_instructions" {
                if (value.string != nil){
                let regex = try! NSRegularExpression(pattern: "<.*?>", options: [.CaseInsensitive])
                let range = NSMakeRange(0, value.string!.characters.count)
                let htmlLessString :String = regex.stringByReplacingMatchesInString(value.string!, options: [],
                    range:range ,
                    withTemplate: "")
                print(htmlLessString)
                self.strings.append(htmlLessString as NSString)
                }
                }
            }
        }
        self.table.reloadData()
        
        self.mapView.addSubview(table)
        UIView.animateWithDuration(0.5, animations: {
            self.table.frame.origin.y = self.view.frame.height - (self.view.frame.height * 0.3)
        })
        
        
    }
    
    func segmentControlChanged(sender: UISegmentedControl){
       // mode = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)!
        if (sender.selectedSegmentIndex == 0){
            selectIndex = 0
            mode = "Driving"
        } else {
            selectIndex = 1
            mode = "Walking"
        }
        getDirections()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return (steps?.count)!
       return strings.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        //cell.frame.height = 50
        if (strings.isEmpty == false){
            cell.textLabel!.text = strings[indexPath.row] as String
        }
        cell.textLabel?.textColor = grayTextColor
        cell.backgroundColor = backgroundColor
        cell.textLabel!.lineBreakMode = .ByWordWrapping
        cell.textLabel!.numberOfLines = 0
        cell.textLabel?.sizeToFit()
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myview = UIView(frame: CGRect(x: 0, y: 0, width: self.table.frame.width, height: 40))
        myview.backgroundColor = backgroundColor
        
        let segmentControl = UISegmentedControl(frame: CGRect(x: 0, y: 0, width: self.table.frame.width - 10, height: 40))
        segmentControl.insertSegmentWithTitle("Driving", atIndex: 0, animated: false)
        segmentControl.insertSegmentWithTitle("Walking", atIndex: 1, animated: false)
        segmentControl.center = myview.center
        segmentControl.tintColor = greenColor
        segmentControl.selectedSegmentIndex = selectIndex
        segmentControl.addTarget(self, action: "segmentControlChanged:", forControlEvents: .ValueChanged)
        myview.addSubview(segmentControl)
        
        return myview
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
         let myview = UIView(frame: CGRect(x: 0, y: 0, width: self.table.frame.width, height: 40))
        myview.backgroundColor = backgroundColor
        return myview
    }
    
    func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
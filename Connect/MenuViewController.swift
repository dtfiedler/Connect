//
//  MenuViewController.swift
//  Connect
//
//  Created by Dylan Fiedler on 1/22/16.
//  Copyright © 2016 xor. All rights reserved.
//

import UIKit
import CoreLocation


class MenuViewController: UITableViewController, CLLocationManagerDelegate {
    
    var topIcons = ["monogram", "events", "marker","compass", "phone"]
    var top = ["HCI", "Events", "", "Floor Map", "Call"]
    var hotelItems = ["building", "dots"]
    var hotel = ["Amenities", "Make A Request"]
    var explore = ["Reccomended", "Maps", "Flights", "Weather"]
    var exploreItems = ["star", "map", "plane", "weather"]
    var me = ["Profile", "Messages", "Checkout"]
    var meIcons = ["profile", "messages2", "exit"]
    var labels = []
    var icons = ["building", "phone","map", "compass", "dots", ""]
    var headers = [ "", "GE Condos", "Explore", "Me"]
    var locationLabel: [String]?
    
    let backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
    let headerBackgroud = UIColor(red: 70/255, green: 173/255, blue: 0/255, alpha: 1.0)//green color
    let grayTextColor = UIColor(red: 59/255, green: 59/255, blue: 63/255, alpha: 1.0)
    let pink = UIColor(red: 242/255, green: 87/255, blue: 100/255, alpha: 1)
    let teal = UIColor(red: 4/255, green: 217/255, blue: 196/255, alpha: 1)
    var currentLocation: [NSDictionary]?
    
    let locationManager = CLLocationManager()
    var isHidden:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isHidden = !isHidden
        UIView.animateWithDuration(0.5) { () -> Void in
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        self.setNeedsStatusBarAppearanceUpdate()
        //UIApplication.sharedApplication().statusBarHidden = true
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    func returnLocation() -> [NSDictionary] {
        return currentLocation!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch (section){
        case 0: return 5
        case 1 : return 2
        case 2: return 4
        case 3: return 3
        default: return 1
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        for view in cell.subviews   {
            if (view is UILabel || view is UIImageView){
                view.removeFromSuperview()
            }
            
        }

        switch(indexPath.section){
        case 0:
            icons = topIcons
            labels = top
            break;
        case 1:
            icons = hotelItems
            labels = hotel
            break
        case 2:
            icons = exploreItems
            labels = explore
            break
        case 3:
            icons = meIcons
            labels = me
            break
        default:
                break
        }        
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        label.textColor = grayTextColor
        label.text = "\(labels[indexPath.row])"
        label.center = CGPoint(x: 110, y: 25)
        label.font = UIFont.systemFontOfSize(18, weight: UIFontWeightLight)
        label.textAlignment = NSTextAlignment.Left
        label.sizeToFit()
        
        let icon = UIImageView()
        if let image = UIImage(named: "\(icons[indexPath.row])"){
            let imageTinted = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            icon.image = imageTinted
            if (indexPath.section == 0 && indexPath.row == 0){
                icon.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            } else {
                icon.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            }
            if (indexPath.section == 0 && indexPath.row == 2){
                icon.center = CGPoint(x: 30, y: 50)
                
                if let address = locationLabel?.joinWithSeparator("\n"){
                    label.numberOfLines = 0
                label.text = address
                label.sizeToFit()
    
                print("here is the address: \(locationLabel?.joinWithSeparator(", "))")
                    
                }
            } else {
                icon.center = CGPoint(x: 30, y: 25)
            }
    
            if (indexPath.section == 0 && indexPath.row == 0){
                icon.tintColor = grayTextColor
                //icon.tintColor = grayTextColor
               // icon.backgroundColor = grayTextColor
            } else {
                icon.tintColor = grayTextColor
            }
           
        }
        
        icon.contentMode = .ScaleAspectFit
        
        cell.addSubview(label)
        cell.addSubview(icon)
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.separatorInset = UIEdgeInsetsZero

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if (indexPath.row == 2 && indexPath.section == 0){
            
            let pushVC = NearbyPlacesViewController()
            let backVC = UIViewController()
            
            if let navigationController = navigationController {
                
                navigationController.pushViewController(pushVC, animated: true)
                
                let stackCount = navigationController.viewControllers.count
                let addIndex = stackCount - 1
                navigationController.viewControllers.insert(backVC, atIndex: addIndex)
                
            }
        }
        
        if (indexPath.row == 0 && indexPath.section == 0){
            NSNotificationCenter.defaultCenter().postNotificationName("homeContent", object: nil)
        }
        
        if (indexPath.row == 1 && indexPath.section == 0){
            NSNotificationCenter.defaultCenter().postNotificationName("events", object: nil)
        }
        
        if (indexPath.row == 2 && indexPath.section == 0){
            NSNotificationCenter.defaultCenter().postNotificationName("nearby", object: nil)
        }
        if (indexPath.row == 3 && indexPath.section == 0){
            NSNotificationCenter.defaultCenter().postNotificationName("floormapContent", object: nil)
//            self.performSegueWithIdentifier("floormap", sender: nil)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0 && indexPath.row == 2){
            return 100
        } else {
            return 50
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 0
        } else {
            return 40.0
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section){
        case 0 : return ""
        case 1: return "GE Conodominums"
        case 2: return "Explore"
        case 3: return "Me"
        default: return ""
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = headerBackgroud
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40)
        headerView.clipsToBounds = true
        let label = UILabel()
        label.frame = CGRect(x: 20, y: 0, width: 400, height: 40)
        label.textColor = UIColor.whiteColor()
        label.text = "\(headers[section])"
        label.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        label.textAlignment = NSTextAlignment.Left
        
        headerView.addSubview(label)
        
        return headerView
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)-> Void in
            if (error != nil) {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count >= 0 {
                let pm = placemarks![0] as CLPlacemark
              //  self.locationLabel = "\(pm.addressDictionary) \(pm.locality) \(pm.postalCode) + \(pm.administrativeArea)"
                let address = pm.addressDictionary!["FormattedAddressLines"] as! [String]
                print(address)
                NSUserDefaults.standardUserDefaults().setObject(address, forKey: "location")
                self.locationLabel = address
                self.tableView.reloadData()
                self.locationManager.stopUpdatingLocation()
                self.locationManager.startMonitoringSignificantLocationChanges()
            } else {
                print("Problem with the data received from geocoder")
            }
        })

    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return .Fade // or return .Fade
    }

    override func prefersStatusBarHidden() -> Bool {
    return isHidden
    }

//    override func prefersStatusBarHidden() -> Bool {
//        
//        return self.navigationController!.navigationBarHidden as Bool
//        
//    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

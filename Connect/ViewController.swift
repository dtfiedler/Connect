//
//  ViewController.swift
//  SDevCircleButton
//
//  Created by Sedat ÇİFTÇİ on 15/10/14.
//  Copyright (c) 2014 Sedat ÇİFTÇİ. All rights reserved.
//

import UIKit
import DKCircleButton
import SDevCircleButton
import JTSlideShadowAnimation
import LGSideMenuController
import GoogleMaps
import OpenWeatherMapAPI

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var bottomView: UIVisualEffectView!
    @IBOutlet weak var imageView: UIImageView!
    let button1 = SDevCircleButton(frame: CGRectMake(0, 0, 75, 75))
    
    let button2 = SDevCircleButton(frame: CGRectMake(0, 0, 75, 75))
    
    let button3 = SDevCircleButton(frame: CGRectMake(0, 0, 75, 75))
    
    let button4 = SDevCircleButton(frame: CGRectMake(0, 0, 75, 75))
    let eggWhite = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
        let grayTextColor = UIColor(red: 59/255, green: 59/255, blue: 63/255, alpha: 1.0)
    let greenColor = UIColor(red: 70/255, green: 173/255, blue: 0/255, alpha: 1.0)
    
    let shadowAnimation = JTSlideShadowAnimation()
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    let label4 = UILabel()
    var myMainViewController = LGSideMenuController()
    var placePicker: GMSPlacePicker?
    var placesClient: GMSPlacesClient?
    //let orange = UIColor(red: 242/255, green: 87/255, blue: 100/255, alpha: 1)
    let teal = UIColor(red: 4/255, green: 217/255, blue: 196/255, alpha: 1)
    let orange = UIColor(red: 255/255, green: 152/255, blue: 33/255, alpha: 1.0)
    
    var helpView = UIView()
    var blurEffect2 = UIBlurEffect(style: UIBlurEffectStyle.Dark)
    var blurEffectView2 = UIVisualEffectView()
    var helpTable = UITableView(frame: CGRectZero)
    var buttonOrigin: CGPoint?
    var icons = ["building", "phone","map", "compass", "dots", ""]
    var options = ["Building Amenities", "Call the hotel", "Local Map", "How do I get to the hotel?", "Make a request"]
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var weatherAPI = OWMWeatherAPI(APIKey: "72e38597fbc296e06e10b441c12b963d")
    
    var location: CLPlacemark?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        //self.setNeedsStatusBarAppearanceUpdate()
        
        weatherLabel.text = ""
        weatherImage.alpha = 0
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "events", name: "events", object: nil)
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "nearby", name: "nearby", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "floormap", name: "floormap", object: nil)
        
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        self.weatherLabel.alpha = 0

        weatherAPI.setTemperatureFormat(kOWMTempFahrenheit)
        self.navigationItem.title = "GE Healthcare Institute"
        
        button1.center = CGPointMake(self.view.frame.width * 0.15, self.view.frame.height - 150)
        button1.titleLabel?.font = UIFont.systemFontOfSize(16, weight: UIFontWeightLight)
        //button1.animateTap = true
        button1.setTitleColor(UIColor(white: 1, alpha: 1.0), forState: UIControlState.Normal)
        button1.setTitleColor(UIColor(white: 1, alpha: 1.0), forState: UIControlState.Selected)
        button1.setTitleColor(UIColor(white: 1, alpha: 1.0), forState: UIControlState.Highlighted)
        button1.animateTap = true
        

        let origImage1 = UIImage(named: "events");
        let tintedImage1 = origImage1?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        button1.setImage(tintedImage1, forState: .Normal)
        button1.tintColor = orange
        button1.imageView?.contentMode = .ScaleAspectFit

        
        button1.borderColor = UIColor.whiteColor()
        button1.borderSize = 2.0
        
        button1.addTarget(self, action: "left", forControlEvents: UIControlEvents.TouchUpInside)
        
        button2.center = CGPointMake(self.view.frame.width/2, self.view.frame.height - 150)
        button2.titleLabel?.font = UIFont.systemFontOfSize(16, weight: UIFontWeightLight)
        button2.setTitleColor(UIColor(white: 1, alpha: 1.0), forState: UIControlState.Normal)
        button2.setTitleColor(UIColor(white: 1, alpha: 1.0), forState: UIControlState.Selected)
        button2.setTitleColor(UIColor(white: 1, alpha: 1.0), forState: UIControlState.Highlighted)
        button2.animateTap = true
        button2.addTarget(self, action: "main", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        let origImage = UIImage(named: "bell");
        let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        button2.setImage(tintedImage, forState: .Normal)
        button2.tintColor = orange
        button2.imageView?.contentMode = .ScaleAspectFit
        button2.borderColor = UIColor.whiteColor()
        button2.borderSize = 2.0
        
        button3.center = CGPointMake(self.view.frame.width * 0.85, self.view.frame.height - 150)
        button3.titleLabel?.font = UIFont.systemFontOfSize(16, weight: UIFontWeightLight)
        //button3.animateTap = true
        button3.setTitleColor(UIColor(white: 1, alpha: 1.0), forState: UIControlState.Normal)
        button3.setTitleColor(UIColor(white: 1, alpha: 1.0), forState: UIControlState.Selected)
        button3.setTitleColor(UIColor(white: 1, alpha: 1.0), forState: UIControlState.Highlighted)
        button3.animateTap = true

        
        let markerImage = UIImage(named: "checkMarker");
        let tintedImage2 = markerImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        button3.setImage(tintedImage2, forState: .Normal)
        button3.tintColor = orange
        button3.imageView?.contentMode = .ScaleAspectFit

        
        button3.addTarget(self, action: "right", forControlEvents: UIControlEvents.TouchUpInside)
        
        button3.borderColor = UIColor.whiteColor()
        button3.borderSize = 2.0
        
        //button3.sc

        label1.text = "Events"
        label1.font = UIFont.systemFontOfSize(12, weight: UIFontWeightLight)
        label1.sizeToFit()
        label1.center.x = button1.center.x
        label1.center.y = button1.center.y + button2.frame.height / 2 + 20
        label1.textColor = UIColor.whiteColor()
        
        label2.text = "How can we help?"
        label2.font = UIFont.systemFontOfSize(12, weight: UIFontWeightLight)
        label2.sizeToFit()
        label2.center.x = button2.center.x
        label2.center.y = label1.center.y
        label2.textColor = UIColor.whiteColor()
        
        label3.text = "I'm Here"
        label3.font = UIFont.systemFontOfSize(12, weight: UIFontWeightLight)
        label3.sizeToFit()
        label3.center.x = button3.center.x
        label3.center.y = label1.center.y
        label3.textColor = UIColor.whiteColor()
        
        
        
        //Slide for menu animation and view
        label4.text = "< < <  Slide for menu  > > >"
        label4.font = UIFont.systemFontOfSize(14, weight: UIFontWeightLight)
        label4.sizeToFit()
        label4.center.x = button2.center.x
        label4.center.y = button2.center.y - button2.frame.height
        label4.textColor = UIColor.whiteColor()
        
        shadowAnimation.animatedView = label4
        shadowAnimation.shadowWidth = 20
        shadowAnimation.duration = 3.0
        shadowAnimation.start()
        
        
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        self.view.addSubview(button3)
        self.view.addSubview(label1)
        self.view.addSubview(label2)
        self.view.addSubview(label3)
        //self.view.addSubview(label4)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = (CGRect(x: 0, y: CGFloat(self.imageView.frame.height) * CGFloat(1.05), width: imageView.frame.width, height: imageView.frame.height))
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        
        let homeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.height / 2,height: 30))
        
        homeLabel.text = "GE Healthcare Institute"
        homeLabel.font = UIFont.systemFontOfSize(25, weight: UIFontWeightLight)
        homeLabel.sizeToFit()
        homeLabel.center = CGPoint(x: self.view.center.x, y: 0)
        homeLabel.textColor = UIColor.whiteColor()
        
        //blurEffectView.addSubview(homeLabel)
        
        self.imageView.addSubview(blurEffectView)
        
        
        //help menu setup
        blurEffect2 = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        blurEffectView2 = UIVisualEffectView(effect: blurEffect2)
        blurEffectView2.frame = (CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height))
        blurEffectView2.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        blurEffectView2.bounds = self.imageView.bounds
        
        helpTable = UITableView(frame: CGRect(x: 0, y: view.frame.height * 0.5, width: self.view.frame.width, height: self.view.frame.height/2))
        helpTable.registerClass(CustomCell.self, forCellReuseIdentifier: "cell")
        helpTable.delegate = self
        helpTable.dataSource = self
        helpTable.backgroundColor = eggWhite
        
        
        button4.center = CGPoint(x: self.imageView.frame.width/2, y: self.helpTable.frame.origin.y - 75)
        button4.titleLabel?.font = UIFont.systemFontOfSize(16, weight: UIFontWeightLight)
        button4.setTitleColor(UIColor(white: 1, alpha: 1.0), forState: UIControlState.Normal)
        button4.setTitleColor(UIColor(white: 1, alpha: 1.0), forState: UIControlState.Selected)
        button4.setTitleColor(UIColor(white: 1, alpha: 1.0), forState: UIControlState.Highlighted)
        button4.animateTap = true
        button4.addTarget(self, action: Selector("closeMenu"), forControlEvents: .TouchUpInside)
        
        let origImage10 = UIImage(named: "cancel");
        let tintedImage10 = origImage10?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        button4.setImage(tintedImage10, forState: .Normal)
        button4.tintColor = orange
        button4.imageView?.contentMode = .ScaleAspectFit
        button4.borderColor = UIColor.whiteColor()
        button4.borderSize = 2.0
        
        blurEffectView2.addSubview(helpTable)
        blurEffectView2.addSubview(button4)
        blurEffectView2.bringSubviewToFront(button4)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        downSwipe.direction = .Down
        rightSwipe.direction = .Right
        
        blurEffectView2.addGestureRecognizer(downSwipe)
        self.view.addGestureRecognizer(rightSwipe)
        self.view.addSubview(self.blurEffectView2)
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        shadowAnimation.animatedView = label4
        shadowAnimation.shadowWidth = 20
        shadowAnimation.duration = 3.0
        shadowAnimation.start()
        
         self.navigationItem.title = "GE Healthcare Institute"
    }
    
    func handleSwipes(sender: UISwipeGestureRecognizer){
        
        switch(sender.direction){
        case UISwipeGestureRecognizerDirection.Down:
            closeMenu()
            break
        case UISwipeGestureRecognizerDirection.Right:
            toggleMenu(self)
            break
        default:
            break
            
        }
    }
    
    func updateWeather(){
        
        print(location)
        
        let city = location?.locality
        
        weatherAPI.currentWeatherByCityName(city, withCallback: {(error: NSError!, result: [NSObject: AnyObject]!) -> Void in
            if (error != nil){
                print("error retriving weather")
                self.weatherLabel.text = "Error retreiveing weather"
            } else {
                let cityName = result["name"] as! String!
                let currentTemp = "\(Int(round(result["main"]!["temp"] as! Float)))\u{00B0}"
                let conditions = result["weather"]!["main"]
                print(result["weather"]!)
                let weather = [cityName, currentTemp] as [String]
                self.weatherLabel.text = weather.joinWithSeparator("\n")
            }})
        
        UIView.animateWithDuration(0.5, animations: {
            self.weatherLabel.alpha = 1
            self.weatherImage.alpha = 1
        })
    }
    
    func left(){
        print("button selected")
        button1.selected = false
        if (label1.text == "Events"){
            self.performSegueWithIdentifier("events", sender: self)
        } else {
            self.performSegueWithIdentifier("messages", sender: self)
        }
    }
    
    func showMessages(){
        
        self.performSegueWithIdentifier("messages", sender: self)
    }
    
    func main(){
        
        //self.helpTable.reloadData()
        print("button selected")

        //self.blurEffectView2.removeFromSuperview()
        
        
        button2.selected = false
        
        helpTable.backgroundColor = eggWhite
        button1.hidden = true
        button2.hidden = true
        button3.hidden = true
        button1.enabled = false
        button2.enabled = false
        button3.enabled = false
        button4.enabled = true

        label1.hidden = true
        label2.hidden = true
        label3.hidden = true
        label4.hidden = true
        
        buttonOrigin = button2.center
        
        
        UIView.animateWithDuration(0.7, animations: {
            
            //self.view.bringSubviewToFront(self.blurEffectView2)
           
            self.blurEffectView2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.button4.center = CGPoint(x: self.imageView.frame.width/2, y: self.helpTable.frame.origin.y - 75)
        })
    

    }
    
    func closeMenu(){
        
        button1.hidden = false
        button2.hidden = false
        button3.hidden = false
        button1.enabled = true
        button2.enabled = true
        button3.enabled = true
        
        label1.hidden = false
        label2.hidden = false
        label3.hidden = false
        label4.hidden = false
        
        UIView.animateWithDuration(0.7, animations: {
            
            self.blurEffectView2.frame = CGRect(x: 0, y: self.view.frame.height + 200, width: self.view.frame.width, height: self.view.frame.height)
        })
        
    }
    
    func right(){
        print("button selected")
        
        label1.text = "Messages"
        label3.text = "Checkout"
        label3.sizeToFit()
        label1.sizeToFit()
        label3.center.x = button3.center.x
        label3.center.y = label2.center.y
        
        label1.center.x = button1.center.x
        label1.center.y = label2.center.y

        
        //button3.triggerAnimateTap()
        let markerImage = UIImage(named: "messages");
        let tintedImage2 = markerImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        button1.setImage(tintedImage2, forState: .Normal)
        button1.tintColor = orange
        button1.imageView?.contentMode = .ScaleAspectFit
        //button1.removeTarget(self, action: "left", forControlEvents: .TouchUpInside)
        //button1.addTarget(self, action: "showMessages", forControlEvents: .TouchUpInside)
        
        let markerImage2 = UIImage(named: "logout");
        let tintedImage1 = markerImage2?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        
        button3.setImage(tintedImage1, forState: .Normal)
        button3.tintColor = orange
        button3.imageView?.contentMode = .ScaleAspectFit
        button3.addTarget(self, action: "right2", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func right2(){
        
        label1.text = "Events"
        label3.text = "I'm Here"
        label3.sizeToFit()
        label1.sizeToFit()
        label3.center.x = button3.center.x
        label3.center.y = label2.center.y

        label1.center.x = button1.center.x
        label1.center.y = label2.center.y

        
        let origImage1 = UIImage(named: "events");
        let tintedImage1 = origImage1?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        button1.setImage(tintedImage1, forState: .Normal)
        button1.tintColor = orange
        button1.imageView?.contentMode = .ScaleAspectFit
        //button1.removeTarget(self, action: ", forControlEvents: <#T##UIControlEvents#>)
       // button1.addTarget(self, action: "left", forControlEvents: .TouchUpInside)
        
        let markerImage2 = UIImage(named: "checkMarker");
        let tintedImage2 = markerImage2?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        button3.setImage(tintedImage2, forState: .Normal)
        button3.tintColor = orange
        button3.imageView?.contentMode = .ScaleAspectFit
        button3.addTarget(self, action: "right", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.helpTable.dequeueReusableCellWithIdentifier("cell")! as! CustomCell

        let icon = UIImageView()
        let image = UIImage(named: "\(icons[indexPath.row])")
        let imageTinted = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        icon.image = imageTinted
        icon.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        icon.center = CGPoint(x: 30, y: cell.center.y)
        icon.tintColor = grayTextColor
        
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        label.textColor = grayTextColor
        label.text = "\(options[indexPath.row])"
        label.center = CGPoint(x: 110, y: 20)
        label.font = UIFont.systemFontOfSize(18, weight: UIFontWeightLight)
        label.textAlignment = NSTextAlignment.Left
        label.textAlignment = .Center
        label.sizeToFit()
        cell.addSubview(label)
        cell.addSubview(icon)
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = greenColor
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        headerView.clipsToBounds = true
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 400, height: 40)
        label.textColor = UIColor.whiteColor()
        label.text = "How can we help you?"
        label.center = headerView.center
        label.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        label.textAlignment = NSTextAlignment.Center
        
        headerView.addSubview(label)
        
        return headerView
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if (indexPath.row == 2){
            //self.findNearby()
            self.performSegueWithIdentifier("nearby", sender: self)
        }
    }
    
    @IBAction func toggleMenu(sender: AnyObject) {
       NSNotificationCenter.defaultCenter().postNotificationName("toggleMenu", object: nil)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)-> Void in
            if (error != nil) {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count >= 0 {
                let pm = placemarks![0] as CLPlacemark
                let address = pm.addressDictionary!["FormattedAddressLines"] as! [String]
                print(address)
                self.location = pm
                NSUserDefaults.standardUserDefaults().setObject(address, forKey: "location")
                self.updateWeather()
                self.locationManager.stopUpdatingLocation()
                self.locationManager.startMonitoringSignificantLocationChanges()
            } else {
                print("Problem with the data received from geocoder")
            }
        })
        
    }
    
    func events(){
        NSNotificationCenter.defaultCenter().postNotificationName("toggleMenu", object: nil)
        self.performSegueWithIdentifier("events", sender: self)
    }
    
    func nearby(){
        NSNotificationCenter.defaultCenter().postNotificationName("toggleMenu", object: nil)
        self.performSegueWithIdentifier("nearby", sender: self)
    }
    
    
    func floormap(){
        NSNotificationCenter.defaultCenter().postNotificationName("toggleMenu", object: nil)
        self.performSegueWithIdentifier("floormap", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.navigationItem.title = ""
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return .Fade // or return .Fade
    }
    
}


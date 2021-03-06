//
//  AppDelegate.swift
//  Connect
//
//  Created by Dylan Fiedler on 1/19/16.
//  Copyright © 2016 xor. All rights reserved.
//

import UIKit
import LGSideMenuController
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var kMainViewController: MainViewController?
    var kNavigationController: UINavigationController?
    
    let googleMapsApiKey = "AIzaSyAaVC1_FoBkiEyRA9DDj1FD0tl97o-Ywp4"

    let backgroundColor = UIColor(red: 82/255, green: 81/255, blue: 86/255, alpha: 1.0)
    let teal = UIColor(red: 4/255, green: 217/255, blue: 196/255, alpha: 1)

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        kMainViewController = UIApplication.sharedApplication().delegate?.window!?.rootViewController as? MainViewController
        kMainViewController?.rootViewLayerShadowRadius = 10
        kMainViewController?.rootViewLayerShadowColor = UIColor.blackColor()
        
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(20, weight: UIFontWeightLight), NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().barTintColor = backgroundColor
        
        UINavigationBar.appearance().barStyle = UIBarStyle.Black
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        GMSServices.provideAPIKey(googleMapsApiKey)
        
         //UIApplication.sharedApplication().statusBarStyle = .LightContent
    
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


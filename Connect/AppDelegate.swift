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
    var mainViewController: LGSideMenuController?
    var rearViewController: LeftMenuTableViewController?
    var frontViewController: ViewController?
    var frontNavigationController: NavigationViewController?
    
    let googleMapsApiKey = "AIzaSyAaVC1_FoBkiEyRA9DDj1FD0tl97o-Ywp4"

    let pink = UIColor(red: 242/255, green: 87/255, blue: 100/255, alpha: 1)
    let teal = UIColor(red: 4/255, green: 217/255, blue: 196/255, alpha: 1)

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(20, weight: UIFontWeightLight), NSForegroundColorAttributeName: pink]
        
        UINavigationBar.appearance().tintColor = pink
        //UINavigationBar.appearance().backgroundColor =  UIColor.whiteColor()
        
       GMSServices.provideAPIKey(googleMapsApiKey)
        
//        window = UIWindow(frame: UIScreen.mainScreen().bounds)
//        //window?.tintColor = UIColor.whitecolor()
//        
//        frontViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("mainController") as? ViewController
//        
//        frontNavigationController = UIStoryboard(name: "Main", bundle:nil).instantiateViewControllerWithIdentifier("NavigationController") as? NavigationViewController
//        
//        rearViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LeftViewController") as? LeftMenuTableViewController
//        
//        mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("sideMenu") as? LGSideMenuController
//        mainViewController?.rootViewController = frontNavigationController
//        mainViewController?.setLeftViewEnabledWithWidth(250, presentationStyle: LGSideMenuPresentationStyle.SlideBelow, alwaysVisibleOptions: LGSideMenuAlwaysVisibleOptions.OnNone)
//        mainViewController?.leftView().addSubview((rearViewController?.tableView)!)
//        
////        if let window = window {
////            window.backgroundColor = UIColor.whiteColor()
////            window.makeKeyAndVisible()
//        window!.rootViewController = mainViewController
//        
//        
        
        
        //}
    
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


//
//  MainViewController.swift
//  Connect
//
//  Created by Dylan Fiedler on 1/20/16.
//  Copyright © 2016 xor. All rights reserved.
//

import UIKit

import LGSideMenuController

class MainViewController: LGSideMenuController {

    var leftShow = false
    var rightShow = false
    
    var leftMenu = MenuViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "toggleMenu", name: "toggleMenu", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "floormapContent", name: "floormapContent", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "homeContent", name: "homeContent", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "messagesContent", name: "messagesContent", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "nearbyContent", name: "nearbyContent", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "surveyContent", name: "surveyContent", object: nil)

        
        
        leftMenu = self.storyboard?.instantiateViewControllerWithIdentifier("MenuViewController") as! MenuViewController
        
        let navigationController = self.storyboard?.instantiateViewControllerWithIdentifier("NavigationController")
       
        self.rootViewController = navigationController
        
        self.setLeftViewEnabledWithWidth(self.view.frame.width * 0.75, presentationStyle: LGSideMenuPresentationStyle.SlideBelow, alwaysVisibleOptions: LGSideMenuAlwaysVisibleOptions.OnNone)

        self.leftView().addSubview(leftMenu.tableView)
        self.leftViewLayerShadowRadius = 10
       // NSNotificationCenter.defaultCenter().addObserver(self, selector: "toggleMenu", name: kLGSideMenuControllerWillShowLeftViewNotification, object: leftMenu)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "toggleMenu", name: kLGSideMenuControllerWillDismissLeftViewNotification, object: leftMenu)
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func floormapContent(){
        self.rootViewController = self.storyboard?.instantiateViewControllerWithIdentifier("FloorMapNavigationController")
        self.rootViewLayerShadowRadius = 10
        toggleMenu()
    }
    
    func homeContent(){
        self.rootViewController = self.storyboard?.instantiateViewControllerWithIdentifier("NavigationController")
        toggleMenu()
    }
    
    func messagesContent(){
        self.rootViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MessagesNavigationController")
            toggleMenu()
    }
    
    func surveyContent(){
        self.rootViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SurveyNavigationController")
        toggleMenu()
    }
    
    func nearbyContent(){
        self.rootViewController = self.storyboard?.instantiateViewControllerWithIdentifier("NearbyNavigationController")
        toggleMenu()
    }

    func toggleMenu(){
        if (UIApplication.sharedApplication().statusBarHidden){
            UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .None)
        }
        self.rootViewLayerShadowRadius = 10.0
        if (!leftShow){
            showLeft()
            leftShow = true
            UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Fade)
            self.leftViewLayerShadowColor = UIColor.orangeColor()
        } else {
            hideLeft()
            leftShow = false
            UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .None)
        }
    }
    
    func showLeft(){
        //self.view.bringSubviewToFront(leftMenu.tableView)
        self.leftViewWillLayoutSubviewsWithSize(CGSize(width: 200, height: 200) )
        self.showLeftViewAnimated(true, completionHandler: nil)
        self.hideRightViewAnimated(true, completionHandler: nil)
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Fade)

        //leftShow = true
    }
    
    func hideLeft(){
       // leftShow = false
        self.hideLeftViewAnimated(true, completionHandler: nil)
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .None)

    }


    func showRight(){
        self.showRightViewAnimated(true, completionHandler: nil)
        self.hideLeftViewAnimated(true, completionHandler: nil)
    }

}

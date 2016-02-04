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
        
        
        
        leftMenu = self.storyboard?.instantiateViewControllerWithIdentifier("MenuViewController") as! MenuViewController
        
        let navigationController = self.storyboard?.instantiateViewControllerWithIdentifier("NavigationController")
       
        self.rootViewController = navigationController
        
        self.setLeftViewEnabledWithWidth(self.view.frame.width * 0.75, presentationStyle: LGSideMenuPresentationStyle.SlideBelow, alwaysVisibleOptions: LGSideMenuAlwaysVisibleOptions.OnNone)

        self.leftView().addSubview(leftMenu.tableView)
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "toggleMenu", name: kLGSideMenuControllerWillShowLeftViewNotification, object: leftMenu)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "toggleMenu", name: kLGSideMenuControllerWillDismissLeftViewNotification, object: leftMenu)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func floormapContent(){
        
        self.rootViewController = self.storyboard?.instantiateViewControllerWithIdentifier("FloorMapNavigationController")
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

    func toggleMenu(){
        if (!leftShow){
            showLeft()
            leftShow = true
        } else {
            hideLeft()
            leftShow = false
        }
    }
    
    func showLeft(){
        self.view.bringSubviewToFront(leftMenu.tableView)
        self.leftViewWillLayoutSubviewsWithSize(CGSize(width: 200, height: 200) )
        self.showLeftViewAnimated(true, completionHandler: nil)
        self.hideRightViewAnimated(true, completionHandler: nil)
        //leftShow = true
    }
    
    func hideLeft(){
       // leftShow = false
        self.hideLeftViewAnimated(true, completionHandler: nil)
    }


    func showRight(){
        self.showRightViewAnimated(true, completionHandler: nil)
        self.hideLeftViewAnimated(true, completionHandler: nil)
    }
//

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

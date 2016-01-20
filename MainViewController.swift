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
    
    var leftMenu = LeftMenuTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "toggleMenu", name: "toggleMenu", object: nil)
        
        leftMenu = self.storyboard?.instantiateViewControllerWithIdentifier("LeftViewController") as! LeftMenuTableViewController
        
        let navigationController = self.storyboard?.instantiateViewControllerWithIdentifier("NavigationController")
       
        self.rootViewController = navigationController
        
        self.setLeftViewEnabledWithWidth(self.view.frame.width * 0.75, presentationStyle: LGSideMenuPresentationStyle.SlideBelow, alwaysVisibleOptions: LGSideMenuAlwaysVisibleOptions.OnNone)

        self.leftView().addSubview(leftMenu.tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        self.leftViewWillLayoutSubviewsWithSize(CGSize(width: 200, height: 200) )
        self.showLeftViewAnimated(true, completionHandler: nil)
        self.hideRightViewAnimated(true, completionHandler: nil)
    }
    
    func hideLeft(){
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

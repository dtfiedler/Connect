//
//  FloorMapViewController.swift
//  Connect
//
//  Created by Dylan Fiedler on 2/3/16.
//  Copyright © 2016 xor. All rights reserved.
//

import UIKit
import LGSideMenuController

class FloorMapViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationItem.title = "Floor Map"
//        let floormap = "./floormap.pdf"
//        let menu = NSBundle.mainBundle().pathForResource(floormap, ofType: "pdf")
//        let url = NSURL.fileURLWithPath(menu!)
//        self.webView.loadRequest(NSURLRequest(URL: url))
        
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
         self.setNeedsStatusBarAppearanceUpdate()
        var pdfLoc = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("floormap", ofType:"pdf")!) //replace PDF_file with your pdf die name
        let request = NSURLRequest(URL: pdfLoc);
        self.webView.loadRequest(request);
        
        self.webView.scrollView.scrollEnabled = true
        self.webView.scalesPageToFit = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func toggleMenu(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("toggleMenu", object: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
                return UIStatusBarStyle.LightContent
    }

}

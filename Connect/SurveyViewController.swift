//
//  SurveyViewController.swift
//  Connect
//
//  Created by Dylan Fiedler on 2/8/16.
//  Copyright © 2016 xor. All rights reserved.
//

import UIKit
import LGSideMenuController


class SurveyViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Survey"
        
        let apiKey = "f444bc0291bb021bf32736717ce739fc44a28523"
        
        let url = NSURL(string: "https://dtfiedler.typeform.com/to/soSMd9")
        let request = NSURLRequest(URL: url!);
        self.webView.loadRequest(request);
        
        self.webView.scrollView.scrollEnabled = true
        self.webView.scalesPageToFit = true

        
        

        // Do any additional setup after loading the view.
    }

    @IBAction func menuButton(sender: AnyObject) {
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

}

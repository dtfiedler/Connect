//
//  MessagesTableViewController.swift
//  Connect
//
//  Created by Dylan Fiedler on 1/20/16.
//  Copyright © 2016 xor. All rights reserved.
//

import UIKit
import DZNSegmentedControl

class MessagesTableViewController: UITableViewController, DZNSegmentedControlDelegate, UIBarPositioningDelegate {

    let label = UILabel()
    
    let teal = UIColor(red: 4/255, green: 217/255, blue: 196/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let search = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: nil)
        
        search.tintColor = UIColor.whiteColor()
        
        self.navigationItem.rightBarButtonItem = search
        
        self.navigationItem.title = "Messages"
        
        self.tableView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        
        let view = UIView()
        view.frame = self.view.frame
        let image = UIImage(named: "empty")
        let tintedImage2 = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)

        let imageView = UIImageView(frame: CGRect(x: self.view.frame.width / 4, y: self.view.frame.height / 3, width: self.view.frame.width / 4, height: self.view.frame.width / 4))
        imageView.center = CGPoint(x: view.center.x, y: view.center.y - (imageView.frame.height / 2))
        imageView.image = tintedImage2
        imageView.tintColor = UIColor.lightGrayColor()
        
        
        label.text = "No new messages\nPull down to refresh"
        label.font = UIFont.systemFontOfSize(14, weight: UIFontWeightLight)
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .Center
        label.textColor = UIColor.lightGrayColor()
        label.center = CGPoint(x: imageView.center.x, y: imageView.center.y + imageView.frame.height / 1.5)
        
        view.addSubview(label)
        view.addSubview(imageView)
        view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        self.view.addSubview(view)
        self.view.bringSubviewToFront(view)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        cell.backgroundColor = UIColor.clearColor()
        // Configure the cell...
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        headerView.backgroundColor = teal
        
        let items = ["Inbox", "Requests"]
        let segmentControl = DZNSegmentedControl(items: items)
        segmentControl.delegate = self
        segmentControl.frame = headerView.frame
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = UIColor.clearColor()
        segmentControl.tintColor = UIColor.whiteColor()
        segmentControl.font = UIFont.systemFontOfSize(16, weight: UIFontWeightLight)
        segmentControl.addTarget(self, action: "segmentControlChanged:", forControlEvents: .ValueChanged)
        //segmentControl.barPosition = UIBarPosition.Bottom
        
        headerView.addSubview(segmentControl)
        
        return headerView   
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .Bottom
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func segmentControlChanged(segmentControl : DZNSegmentedControl){
        switch (segmentControl.selectedSegmentIndex) {
            case 0:
            label.text = "No new messages\nPull down to refresh"
            break
            case 1:
            label.text = "No new requests\nPull down to refresh"
            break
            default:
            break
        }
    }

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

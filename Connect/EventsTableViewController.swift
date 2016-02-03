//
//  EventsTableViewController.swift
//  Connect
//
//  Created by Dylan Fiedler on 1/29/16.
//  Copyright © 2016 xor. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController {
    
    let pink = UIColor(red: 242/255, green: 87/255, blue: 100/255, alpha: 1)
    
    let events = ["Customer Ultrasound Demo", "MRI Breakdown", "CT Showcase", "The Rise of Digital", "Life Sciences Seminar", "GEHC Webinar", "MRI Showcase", "Q4 Recap", "GEHC: What's next"]
    
    let rooms = ["2504", "5029", "2342", "1402", "8585", "1000", "1049", "8918", "5820", "1405", "2231", "5502"]
    
    let times = [ "8:30 AM","9:30 AM","10:00 AM", "11:00 AM","12:00 PM", "12:30 PM", "1:00 PM", "2:00 PM", "3:30 PM","4:00 PM",  "6:30 PM" ]

    let eggWhite = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
    let grayTextColor = UIColor(red: 59/255, green: 59/255, blue: 63/255, alpha: 1.0)
    let greenColor = UIColor(red: 70/255, green: 173/255, blue: 0/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Events"
        self.tableView.backgroundColor = eggWhite
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
        return events.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! EventsTableViewCell

         //Configure the cell...
        
        cell.header.text = "  \(events[indexPath.row])"
        cell.room.text = "Room#: \(rooms[indexPath.row])"
        cell.time.text = "\(times[indexPath.row])"
        cell.room.textColor = grayTextColor
        cell.time.textColor = grayTextColor
        //cell.imageView!.center = CGPoint(x: 100, y: 40)
        let imageView = UIImageView(frame: CGRect(x: 20, y: 75, width: 80, height: 80))
        imageView.image = UIImage(named: "noImage")
        imageView.tintColor = UIColor.lightGrayColor()
        cell.addSubview(imageView)
        cell.backgroundColor = UIColor.clearColor()
        //cell.imageView?.contentMode = .Center
        //cell.imageView!.frame = CGRect(x: cell.imageView!.frame.origin.x + 10000, y: cell.imageView!.frame.origin.y, width: cell.imageView!.frame.width, height: cell.imageView!.frame.height)
        return cell
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

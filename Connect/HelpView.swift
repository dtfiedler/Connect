//
//  HelpView.swift
//  Connect
//
//  Created by Dylan Fiedler on 1/20/16.
//  Copyright © 2016 xor. All rights reserved.
//

import UIKit

class HelpView: UIView, UITableViewDataSource, UITableViewDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.frame = frame
        
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("helpItems")! as UITableViewCell
        
        return cell
    }
}


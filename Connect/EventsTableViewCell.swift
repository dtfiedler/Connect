//
//  EventsTableViewCell.swift
//  Connect
//
//  Created by Dylan Fiedler on 1/29/16.
//  Copyright © 2016 xor. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var header: UILabel!
    
    @IBOutlet weak var room: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    //@IBOutlet weak var imageview: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  CustomCell.swift
//  Pods
//
//  Created by Dylan Fiedler on 1/20/16.
//
//

import UIKit

class CustomCell: UITableViewCell {
    
    var icon = UIImageView()
    var titleLabel =  UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        icon.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        titleLabel.frame = CGRect(x: 40, y: 10, width: 200, height: 50)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

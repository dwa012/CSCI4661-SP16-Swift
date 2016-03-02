//
//  CustomCell.swift
//  lab4
//
//  Created by Daniel Ward on 2/24/16.
//  Copyright © 2016 Daniel Ward. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var customLabel: UILabel!
    @IBOutlet weak var customView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

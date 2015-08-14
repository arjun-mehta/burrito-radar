//
//  RestaurantTableViewCell.swift
//  BurritoRadar
//
//  Created by Arjun Mehta on 8/13/15.
//  Copyright (c) 2015 Arjun Mehta. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var ratingsImageInTable: UIImageView!
    @IBOutlet weak var reviewCountInTable: UILabel!
    @IBOutlet weak var distanceInTable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

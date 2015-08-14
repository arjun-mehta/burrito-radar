//
//  RestaurantTableViewCell.swift
//  BurritoRadar
//
//  Created by Arjun Mehta on 8/13/15.
//  Copyright (c) 2015 Arjun Mehta. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    var address: String!
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var ratingsImageInTable: UIImageView!
    @IBOutlet weak var reviewCountInTable: UILabel!
    @IBOutlet weak var distanceInTable: UILabel!
    
    var shouldUseGoogleMaps: Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        shouldUseGoogleMaps = (UIApplication.sharedApplication().canOpenURL(NSURL(string: "comgooglemaps://")!))

    }

    @IBAction func routeButton(sender: UIButton) {
        
        address = "\(address)"
        var addressWithPluses:String = address.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
        if shouldUseGoogleMaps == true {
            
            let url = NSURL(string: "comgooglemaps://?saddr=&daddr=\(addressWithPluses)")
            UIApplication.sharedApplication().openURL(url!)
        }
            
        else {
            
            let url = NSURL(string: "http://maps.apple.com/maps?saddr=Current%20Location&daddr=\(addressWithPluses)")
            UIApplication.sharedApplication().openURL(url!)
        }
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

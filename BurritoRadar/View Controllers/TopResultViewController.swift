//
//  TopResultViewController.swift
//  BurritoRadar
//
//  Created by Arjun Mehta on 8/12/15.
//  Copyright (c) 2015 Arjun Mehta. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TopResultViewController: UIViewController {
    
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var reviewCount: UILabel!
    
    var tempFullArray: [Business]!
    
    var placeholderImage2: UIImage!
    var placeholderImage: UIImage!
    var nameLabelText: String!
    var addressLabelText: String!
    var distanceLabelText: String!
    var reviewCountText: String!
    
    var shouldUseGoogleMaps: Bool!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantImage.image = placeholderImage
        nameLabel.text = nameLabelText
        addressLabel.text = addressLabelText
        distanceLabel.text = distanceLabelText + "les away"
        ratingImage.image = placeholderImage2
        reviewCount.text = reviewCountText + " reviews"
        
        shouldUseGoogleMaps = (UIApplication.sharedApplication().canOpenURL(NSURL(string: "comgooglemaps://")!))


        
    }
    
    @IBAction func routeButton(sender: UIButton) {
        
        let address = "\(tempFullArray[0].address!)"
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

    @IBAction func viewAllResults(sender: UIButton) {
        
        self.performSegueWithIdentifier("viewAllResultsSegue", sender: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destViewController2: ViewAllTableViewController = segue.destinationViewController as! ViewAllTableViewController
        
       // destViewController2.nameLabelText = tempFullArray[0].name!
        destViewController2.fullArray = tempFullArray
        
        
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

//
//  ViewController.swift
//  BurritoRadar
//
//  Created by Arjun Mehta on 8/11/15.
//  Copyright (c) 2015 Arjun Mehta. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ButtonViewController: UIViewController, CLLocationManagerDelegate {
    
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!

    let locationManager = CLLocationManager()
    
    var businesses: [Business]!
    
    @IBAction func burritoButton(sender: UIButton) {
      
        Business.searchWithTerm("Restaurants", sort: .HighestRated, lat: latitude, long: longitude, radius: 8047, categories: ["mexican"], deals: false) { (businesses: [Business]!, error: NSError!) -> Void in
            
            self.businesses = businesses
            
            self.performSegueWithIdentifier("topResultSegue", sender: self)
        
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = true
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destViewController: TopResultViewController = segue.destinationViewController as! TopResultViewController
        
        destViewController.nameLabelText = businesses[0].name!
        destViewController.addressLabelText = businesses[0].address!
        destViewController.distanceLabelText = businesses[0].distance!
        destViewController.reviewCountText = "\(businesses[0].reviewCount!)"
        
        destViewController.tempFullArray = businesses
        
        let foodurl = businesses[0].imageURL!
        let fooddata = NSData(contentsOfURL: foodurl) //make sure your image in this url does exist, otherwise unwrap in a if let check
        destViewController.placeholderImage = UIImage(data: fooddata!)
        
        let ratingurl = businesses[0].ratingImageURL!
        let ratingdata = NSData(contentsOfURL: ratingurl) //make sure your image in this url does exist, otherwise unwrap in a if let check
        destViewController.placeholderImage2 = UIImage(data: ratingdata!)
        
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation:CLLocation = locations[0] as! CLLocation
        longitude = userLocation.coordinate.longitude;
        latitude = userLocation.coordinate.latitude;
        println(latitude)
        println(longitude)
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error while updating location " + error.localizedDescription)
    }

    
}




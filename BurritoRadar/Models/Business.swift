//
//  Business.swift
//  BurritoRadar
//
//  Created by Arjun Mehta on 8/11/15.
//  Copyright (c) 2015 Arjun Mehta. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class Business {
    let name: String?
    let address: String?
    let imageURL: NSURL?
    let categories: String?
    let distance: String?
    let ratingImageURL: NSURL?
    let reviewCount: NSNumber?
    let radius: NSNumber?
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        
        let imageURLString = dictionary["image_url"] as? String
        if imageURLString != nil {
            imageURL = NSURL(string: imageURLString!)!
        } else {
            imageURL = nil
        }
        
        let location = dictionary["location"] as? NSDictionary
        var address = ""
        if location != nil {
            let addressArray = location!["address"] as? NSArray
            var street: String? = ""
            if addressArray != nil && addressArray!.count > 0 {
                address = addressArray![0] as! String
            }
            
            var neighborhoods = location!["neighborhoods"] as? NSArray
            if neighborhoods != nil && neighborhoods!.count > 0 {
                if !address.isEmpty {
                    address += ", "
                }
                address += neighborhoods![0] as! String
            }
        }
        self.address = address
        
        let categoriesArray = dictionary["categories"] as? [[String]]
        if categoriesArray != nil {
            var categoryNames = [String]()
            for category in categoriesArray! {
                var categoryName = category[0]
                categoryNames.append(categoryName)
            }
            categories = ", ".join(categoryNames)
        } else {
            categories = nil
        }
        
        let distanceMeters = dictionary["distance"] as? NSNumber
        if distanceMeters != nil {
            let milesPerMeter = 0.000621371
            distance = String(format: "%.2f mi", milesPerMeter * distanceMeters!.doubleValue)
        } else {
            distance = nil
        }
        
        let ratingImageURLString = dictionary["rating_img_url_large"] as? String
        if ratingImageURLString != nil {
            ratingImageURL = NSURL(string: ratingImageURLString!)
        } else {
            ratingImageURL = nil
        }
        
        reviewCount = dictionary["review_count"] as? NSNumber
        
        radius = dictionary["radius"] as? NSNumber
    }
    
    class func businesses(#array: [NSDictionary]) -> [Business] {
        var businesses = [Business]()
        for dictionary in array {
            var business = Business(dictionary: dictionary)
            businesses.append(business)
        }
        return businesses
    }
    
    class func searchWithTerm(term: String, completion: ([Business]!, NSError!) -> Void) {
        YelpClient.sharedInstance.searchWithTerm(term, completion: completion)
    }
    
    class func searchWithTerm(term: String, sort: YelpSortMode?, lat: CLLocationDegrees?, long:CLLocationDegrees?, radius: Int, categories: [String]?, deals: Bool?, completion: ([Business]!, NSError!) -> Void) -> Void {
        YelpClient.sharedInstance.searchWithTerm(term, sort: sort, lat: lat, long:long, radius: radius, categories: categories, deals: deals, completion: completion)
    }
}
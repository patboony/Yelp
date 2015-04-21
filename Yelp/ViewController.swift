//
//  ViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var client: YelpClient!
    
    @IBOutlet weak var restaurantSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    let yelpConsumerKey = "EKOsTFalGLeKgSxdCCxacQ"
    let yelpConsumerSecret = "xCwmQAUReBEMIcHVECFL9r6qzlE"
    let yelpToken = "_uGGcFWzW_YQPz5zBY8tL-X3R2bsvUUL"
    let yelpTokenSecret = "tAnH5CiC6-rgHEi2AyHDOYDyduA"
    
    var restaurantList = [NSDictionary]()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.titleView = self.restaurantSearchBar
        // Do any additional setup after loading the view, typically from a nib.
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm("Thai", success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //println(response["businesses"])
            self.restaurantList = response["businesses"] as! [NSDictionary]
            self.tableView.delegate = self;
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println(error)
        }
        

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RestaurantCell", forIndexPath: indexPath) as! RestaurantCell
        let restaurantInfo = restaurantList[indexPath.row]
        cell.restaurantNameLabel.text = restaurantInfo["name"] as! String
        cell.restaurantAddressLabel.sizeToFit()
        println(restaurantInfo)
        
        let restaurantLocationDict = restaurantInfo["location"] as! NSDictionary
        let restaurantLocationDisplay = restaurantLocationDict["display_address"] as! NSArray
        let addressToDisplay = (restaurantLocationDisplay[0] as! String)
        let neighborhoodToDisplay = (restaurantLocationDisplay[1] as! String)
        cell.restaurantAddressLabel.text = addressToDisplay + ", " + neighborhoodToDisplay
        cell.restaurantAddressLabel.sizeToFit()
        
        var reviewCount = String(restaurantInfo["review_count"] as! Int)
        reviewCount += " Reviews"
        cell.restaurantReviewCountLabel.text = reviewCount
        
        let imageURL = restaurantInfo["image_url"] as! String
        cell.restaurantImageView.setImageWithURL(NSURL(string: imageURL))
        
        let ratingImageURL = restaurantInfo["rating_img_url_large"] as! String
        println(ratingImageURL)
        cell.restaurantRatingImageView.setImageWithURL(NSURL(string: ratingImageURL))
        
        var categoryToDisplay = ""
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantList.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


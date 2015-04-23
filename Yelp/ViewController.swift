//
//  ViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2015 Pat Boonyarittipong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, SaveFilterDelegate {
    var client: YelpClient!
    
    @IBOutlet weak var restaurantSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let yelpConsumerKey = "EKOsTFalGLeKgSxdCCxacQ"
    let yelpConsumerSecret = "xCwmQAUReBEMIcHVECFL9r6qzlE"
    let yelpToken = "_uGGcFWzW_YQPz5zBY8tL-X3R2bsvUUL"
    let yelpTokenSecret = "tAnH5CiC6-rgHEi2AyHDOYDyduA"
    
    var restaurantList = [NSDictionary]()
    var searchKeyword = "Thai"
    
    var filtersDict = [String:Int]()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        navigationItem.titleView = restaurantSearchBar
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 90
        
        searchForRestaurants()
    }
    
    func searchForRestaurants(){
        
        // Do any additional setup after loading the view, typically from a nib.
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm(searchKeyword, filter: filtersDict, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //println(response["businesses"])
            self.restaurantList = response["businesses"] as! [NSDictionary]

            self.tableView.reloadData()
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RestaurantCell", forIndexPath: indexPath) as! RestaurantCell
        let restaurantInfo = restaurantList[indexPath.row]
        cell.restaurantNameLabel.text = restaurantInfo["name"] as! String
        //cell.restaurantNameLabel.sizeToFit()

        println(restaurantInfo)
        
        let restaurantLocationDict = restaurantInfo["location"] as! NSDictionary
        let restaurantLocationDisplay = restaurantLocationDict["display_address"] as! NSArray
        let restaurantCategoriesArray = restaurantInfo["categories"] as! NSArray
        var addressToDisplay = "n/a"
        var neighborhoodToDisplay = "n/a"
        
        if restaurantLocationDisplay.count >= 1  {
            addressToDisplay = (restaurantLocationDisplay[0] as! String)
        }
        
        if restaurantLocationDisplay.count >= 2 {
            neighborhoodToDisplay = (restaurantLocationDisplay[1] as! String)
        }
        
        cell.restaurantAddressLabel.text = addressToDisplay + ", " + neighborhoodToDisplay
        //cell.restaurantAddressLabel.sizeToFit()

        var categoryLabel = ""
        for (catArray) in restaurantCategoriesArray {
            categoryLabel += String(stringInterpolationSegment: catArray[0]) + ", "
        }

        // Remove the trailing comma
        let stringLength = count(categoryLabel)
        let substringIndex = stringLength - 2
        cell.restaurantCategoryLabel.text = categoryLabel.substringToIndex(advance(categoryLabel.startIndex, substringIndex))
        //cell.restaurantCategoryLabel.sizeToFit()
        
        var reviewCount = String(restaurantInfo["review_count"] as! Int)
        reviewCount += " Reviews"
        cell.restaurantReviewCountLabel.text = reviewCount
        
        if let imageURL = restaurantInfo["image_url"] as? String {
            cell.restaurantImageView.setImageWithURL(NSURL(string: imageURL))
        }
        
        if let ratingImageURL = restaurantInfo["rating_img_url_large"] as? String {
            cell.restaurantRatingImageView.setImageWithURL(NSURL(string: ratingImageURL))
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantList.count
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchKeyword = searchText
        if searchKeyword == "" {
        searchKeyword = "Thai"
        }
        NSLog(searchKeyword)
        searchForRestaurants()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func saveFilterValue(filtersTableViewController: FiltersTableViewController, filterValue value:[String:Int]){
        filtersDict = value
        searchForRestaurants()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "filterModal" { //<< Set this in the StoryBoard!!!!!!
            let filterTableNC = segue.destinationViewController as! UINavigationController
            let filterTableVC = filterTableNC.visibleViewController as! FiltersTableViewController
            filterTableVC.delegate = self
            filterTableVC.currentFilterOptional = filtersDict
            println("set delegate!")
        }
        //var filterTableVC = segue.destinationViewController as! FiltersTableViewController
        //var indexPath = tableView.indexPathForCell(sender as! RestaurantCell) as NSIndexPath!
        //filterTableVC.delegate = self

    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    

    
    
    
}


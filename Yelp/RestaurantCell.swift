//
//  RestaurantCell.swift
//  Yelp
//
//  Created by Pat Boonyarittipong on 4/20/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {

    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantReviewCountLabel: UILabel!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var restaurantCategoryLabel: UILabel!
    @IBOutlet weak var restaurantDistanceLabel: UILabel!
    @IBOutlet weak var restaurantRatingImageView: UIImageView!
    
    var restaurantInfo: NSDictionary = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        restaurantAddressLabel.preferredMaxLayoutWidth = restaurantAddressLabel.frame.width
        restaurantNameLabel.preferredMaxLayoutWidth = restaurantNameLabel.frame.width
        restaurantReviewCountLabel.preferredMaxLayoutWidth = restaurantReviewCountLabel.frame.width
    }

}

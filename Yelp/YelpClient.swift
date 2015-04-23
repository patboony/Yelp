//
//  YelpClient.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class YelpClient: BDBOAuth1RequestOperationManager {
    var accessToken: String!
    var accessSecret: String!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        var baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        var token = BDBOAuthToken(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func searchWithTerm(term: String, filter: [String:Int], success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        var parameters = ["term": term, "location": "94109"]
        
        for (keyName, value) in filter {
            switch keyName {
            case "deal":
                if value == 1 {
                    parameters["deals_filter"] = "true"
                } else {
                    parameters["deals_filter"] = "false"
                }
            case "distance":
                if value == -1 {
                    parameters["radius_filter"] = nil
                }
                if value == 0 {
                    parameters["radius_filter"] = "482"
                }
                if value == 1 {
                    parameters["radius_filter"] = "1609"
                }
                if value == 5 {
                    parameters["radius_filter"] = "8046"
                }
                if value == 20 {
                    parameters["radius_filter"] = "32186"
                }
            case "sort":
                parameters["sort"] = String(value)
                
            default:
                if keyName != "" {
                    parameters["category_filter"] = keyName
                } else {
                    parameters["category_filter"] = nil
                }
                
            }
            
        }
        
        return self.GET("search", parameters: parameters, success: success, failure: failure)
    }
    
}



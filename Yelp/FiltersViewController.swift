//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Pat Boonyarittipong on 4/20/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 50
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 100)   )
        headerView.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        var settingLabel = UILabel()
        switch(section){
        case 0:
            settingLabel.text = "Price"
            break;
        case 1:
            settingLabel.text = "Distance"
            break;
        case 2:
            settingLabel.text = "Sort"
            break;
        default:
            break;
        }
        
        //settingLabel.textColor = UIColor(white: 0.0, alpha: 0.5)
        headerView.insertSubview(settingLabel, atIndex:0)
        
        return headerView
    }
    
    /*
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        println("section num = 3")
        return 3
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("section to show = " + String(section))
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            var cell = tableView.dequeueReusableCellWithIdentifier("SegmentCell", forIndexPath: indexPath) as! SegmentCell
            return cell
        case 1:
            var cell = tableView.dequeueReusableCellWithIdentifier("FilterCell", forIndexPath: indexPath) as! FilterCell
            return cell
        default:
            var cell = tableView.dequeueReusableCellWithIdentifier("FilterCell", forIndexPath: indexPath) as! FilterCell
            return cell
        }   
    }
*/

    @IBAction func searchButtonPressed(sender: AnyObject) {
    // Use protocol to send settings back to the main view
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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

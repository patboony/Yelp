//
//  FiltersTableViewController.swift
//  Yelp
//
//  Created by Pat Boonyarittipong on 4/21/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

protocol SaveFilterDelegate {
    func saveFilterValue(filtersTableViewController: FiltersTableViewController, filterValue value:[String:Int])
}

class FiltersTableViewController: UITableViewController {
    
    @IBOutlet weak var dealSwitch: UISwitch!
    @IBOutlet weak var autoCell: UITableViewCell!
    @IBOutlet weak var pointThreeMilesCell: UITableViewCell!
    @IBOutlet weak var oneMileCell: UITableViewCell!
    @IBOutlet weak var fiveMilesCell: UITableViewCell!
    @IBOutlet weak var twentyMilesCell: UITableViewCell!
    @IBOutlet weak var bestMatchCell: UITableViewCell!
    @IBOutlet weak var distanceCell: UITableViewCell!
    @IBOutlet weak var ratingCell: UITableViewCell!
    @IBOutlet weak var restaurantCatCell: UITableViewCell!
    @IBOutlet weak var artsCatCell: UITableViewCell!
    @IBOutlet weak var fitnessCatCell: UITableViewCell!
    @IBOutlet weak var nightlifeCatCell: UITableViewCell!
    
    
    var delegate:SaveFilterDelegate?
    var currentFilterOptional: [String:Int]?
    var filterDictionary = [String:Int]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        restoreFilterSettings()

    }
    
    func restoreFilterSettings(){
        if let currentFilter = currentFilterOptional {
            if let distanceFilter = currentFilter["distance"] {
                autoCell.accessoryType = UITableViewCellAccessoryType.None
                switch distanceFilter {
                case 0:
                    pointThreeMilesCell.accessoryType =  UITableViewCellAccessoryType.Checkmark
                case 1:
                    oneMileCell.accessoryType =  UITableViewCellAccessoryType.Checkmark
                case 5:
                    fiveMilesCell.accessoryType =  UITableViewCellAccessoryType.Checkmark
                case 20:
                    twentyMilesCell.accessoryType =  UITableViewCellAccessoryType.Checkmark
                default:
                    autoCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
            }
            
            if let sortFilter = currentFilter["sort"] {
                bestMatchCell.accessoryType = UITableViewCellAccessoryType.None
                switch sortFilter {
                case 1:
                    distanceCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                case 2:
                    ratingCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                default:
                    bestMatchCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
            }
            
            if let dealFilter = currentFilter["deal"] {
                switch dealFilter {
                case 1:
                    dealSwitch.on = true
                default:
                    dealSwitch.on = false
                }
            }
            
            // Default Cateogry Settings
            restaurantCatCell.accessoryType = UITableViewCellAccessoryType.Checkmark
            artsCatCell.accessoryType = UITableViewCellAccessoryType.None
            fitnessCatCell.accessoryType = UITableViewCellAccessoryType.None
            nightlifeCatCell.accessoryType = UITableViewCellAccessoryType.None
            
            if let artsFilter = currentFilter["arts"] {
                restaurantCatCell.accessoryType = UITableViewCellAccessoryType.None
                artsCatCell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            
            if let fitnessFilter = currentFilter["fitness"] {
                restaurantCatCell.accessoryType = UITableViewCellAccessoryType.None
                fitnessCatCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                
            }
            
            if let nightlifeFilter = currentFilter["nightlife"] {
                restaurantCatCell.accessoryType = UITableViewCellAccessoryType.None
                nightlifeCatCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func searchButtonPressed(sender: AnyObject) {

        // Distance Filter
        if autoCell.accessoryType == UITableViewCellAccessoryType.Checkmark {
            filterDictionary["distance"] = -1
        }
        if pointThreeMilesCell.accessoryType == UITableViewCellAccessoryType.Checkmark {
            filterDictionary["distance"] = 0
        }
        if oneMileCell.accessoryType == UITableViewCellAccessoryType.Checkmark {
            filterDictionary["distance"] = 1
        }
        if fiveMilesCell.accessoryType == UITableViewCellAccessoryType.Checkmark {
            filterDictionary["distance"] = 5
        }
        if twentyMilesCell.accessoryType == UITableViewCellAccessoryType.Checkmark {
            filterDictionary["distance"] = 20
        }
        
        // Sort by
        if bestMatchCell.accessoryType == UITableViewCellAccessoryType.Checkmark {
            filterDictionary["sort"] = 0
        }
        
        if distanceCell.accessoryType == UITableViewCellAccessoryType.Checkmark {
            filterDictionary["sort"] = 1
        }
        
        if ratingCell.accessoryType == UITableViewCellAccessoryType.Checkmark {
            filterDictionary["sort"] = 2
        }
        
        // Deal Filter
        filterDictionary["deal"] = 0
        if dealSwitch.on {
            filterDictionary["deal"] = 1
        }
        
        if restaurantCatCell.accessoryType == UITableViewCellAccessoryType.Checkmark {
            filterDictionary["restaurants"] = 1
        }
        
        if artsCatCell.accessoryType == UITableViewCellAccessoryType.Checkmark {
            filterDictionary["arts"] = 1
        }
        
        if fitnessCatCell.accessoryType == UITableViewCellAccessoryType.Checkmark {
            filterDictionary["fitness"] = 1
        }
        
        if nightlifeCatCell.accessoryType == UITableViewCellAccessoryType.Checkmark {
            filterDictionary["nightlife"] = 1
        }
        
        delegate?.saveFilterValue(self, filterValue: filterDictionary)
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        switch section {
        case 0:
            return 1
        case 1:
            return 5
        case 2:
            return 3
        case 3:
            return 4
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 1:
            autoCell.accessoryType = UITableViewCellAccessoryType.None
            pointThreeMilesCell.accessoryType =  UITableViewCellAccessoryType.None
            oneMileCell.accessoryType =  UITableViewCellAccessoryType.None
            fiveMilesCell.accessoryType =  UITableViewCellAccessoryType.None
            twentyMilesCell.accessoryType =  UITableViewCellAccessoryType.None
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        case 2:
            bestMatchCell.accessoryType = UITableViewCellAccessoryType.None
            distanceCell.accessoryType = UITableViewCellAccessoryType.None
            ratingCell.accessoryType = UITableViewCellAccessoryType.None
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        case 3:
            restaurantCatCell.accessoryType = UITableViewCellAccessoryType.None
            artsCatCell.accessoryType = UITableViewCellAccessoryType.None
            fitnessCatCell.accessoryType = UITableViewCellAccessoryType.None
            nightlifeCatCell.accessoryType = UITableViewCellAccessoryType.None
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        default:
            break
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

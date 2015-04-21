//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Pat Boonyarittipong on 4/20/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section){
        case 0:
            return 1
            break
        case 1:
            return 2
            break
        case 2:
            return 2
            break
        default:
            break
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //println("section" + String(indexPath.section))
        if indexPath.section == 0 {
            var cell = tableView.dequeueReusableCellWithIdentifier("FilterCell", forIndexPath: indexPath) as! FilterCell
            return cell
        }
        if indexPath.section == 1 {
            var cell = tableView.dequeueReusableCellWithIdentifier("PickerCell", forIndexPath: indexPath) as! PickerCell
            return cell
        }
        return tableView.dequeueReusableCellWithIdentifier("FilterCell", forIndexPath: indexPath) as! FilterCell
    }
    

    @IBAction func searchButtonPressed(sender: AnyObject) {
    // Use protocol to send settings back to the main view
        
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

//
//  HistoryViewController.swift
//  ProvidenceWayfinding
//
//  Created by Derek Becker on 2/9/16.
//  Copyright © 2016 GU. All rights reserved.
//

import UIKit

class HistoryViewController: UITableViewController{
    @IBOutlet var table: UITableView!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var building = [String()]
    var floor =  [String()]
    var dateSave = [String()]
    var timeSave = [String()]
    var curIndex = Int()
    var flag = Int()
    var index = 0
    var pathFlag = Int()
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (building.count - 1)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:BasicDirectionsCell = tableView.dequeueReusableCellWithIdentifier("historyCell", forIndexPath: indexPath) as! BasicDirectionsCell
        cell.subtitleLabel.text = floor[indexPath.item]
        cell.titleLabel.text = building[indexPath.item]
        cell.subtitle2Label.text = timeSave[indexPath.item]
        cell.title2Label.text = dateSave[indexPath.item]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let check = defaults.integerForKey("savedParkingEver")
        if (check == 1){
            let cell = tableView.cellForRowAtIndexPath(indexPath)! as! BasicDirectionsCell
            
            parkingHistEntry = Directory(name: cell.titleLabel.text! + " Parking " + cell.subtitleLabel.text!, category: "Parking", floor: cell.subtitleLabel.text!, hours: "NA", ext: "", notes: "")
            
            routeFromWhichScreen = 3
            flagForPlace = 1
            resetToRootView = 1
            tabBarController?.selectedIndex = 1
        }
        else{
            let alertTitle = "Error!"
            let alertMessage = "There is no saved parking location to route to!"
            let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in
                alertController.dismissViewControllerAnimated(true, completion: nil)
            }))
            presentViewController(alertController, animated: false, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.layer.borderWidth = 0.5
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80.0
        if(flag == 1){
            index = curIndex
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        pathFlag = Int(defaults.stringForKey("pathFlag")!)!
        if (pathFlag == 1) {
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(false)
            }
        }
    }

    
    
}
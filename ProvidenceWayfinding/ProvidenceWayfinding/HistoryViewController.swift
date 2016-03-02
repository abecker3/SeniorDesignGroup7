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
    var maxKeyNum = Int()
    var thisArray = [String()]
    var cellArray = [String()]
    var curIndex = Int()
    var flag = Int()
    var index = 0
    var count = 10
    var pathFlag = Int()
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        //return cellArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:BasicDirectionsCell = tableView.dequeueReusableCellWithIdentifier("historyCell", forIndexPath: indexPath) as! BasicDirectionsCell
        cell.subtitleLabel.text = "Floor: L2"
        cell.titleLabel.text = "Women's Health Center"
        cell.subtitle2Label.text = "11:52 AM"
        cell.title2Label.text = "2/23/2016"
        return cell
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("historyCell", forIndexPath: indexPath)
        cell.textLabel?.lineBreakMode = .ByWordWrapping
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.text = cellArray[indexPath.item]
        return cell
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.layer.borderWidth = 0.5
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80.0
        if(flag == 1){
            index = curIndex
        }
        createCellArray()
        //table.reloadData()
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
    
    
    func createCellArray(){
        if (flag == 1){
            var iteration = 0
            while (iteration < 10){
                let location = thisArray[index + 1]
                let date = thisArray[index + 2]
                cellArray.append(String(count) + ": " + location + "on " + date)
                index = (index + 3) % 30
                count = count - 1
                iteration++
            }
        }
        else if (maxKeyNum != 0){
            count = (thisArray.count - 1) / 3
            while (index < thisArray.count - 1){
                let location = thisArray[index + 1]
                let date = thisArray[index + 2]
                cellArray.append(String(count) + ": " + location + "on " + date)
                index = (index + 3) % 30
                count = count - 1
            }
        }
        cellArray = cellArray.reverse()
    }
    
    
}
//
//  ServicesTableViewController.swift
//  ProvidenceWayfinding
//
//  Created by Shaun McBurney on 11/30/15.
//  Copyright © 2015 GU. All rights reserved.
//

import UIKit

class ServicesTableViewController: UITableViewController {
    
    // Variables
    var options: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initOptions()
    }
    
    func initOptions()
    {
        options = uniqueCategoryArray(locations)
        options.sortInPlace()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func uniqueCategoryArray(inputArray: [Location]!) -> [String]!
    {
        var newArray = [String]()
        for x in inputArray
        {
            if(newArray.contains(x.category))
            {
                continue
            }
            else
            {
                newArray.append(x.category)
            }
        }
        
        return newArray
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("building", forIndexPath: indexPath)
        
        // Configure the cell...
        let option = options[indexPath.row]
        cell.textLabel!.text = option
        
        return cell
    }
}

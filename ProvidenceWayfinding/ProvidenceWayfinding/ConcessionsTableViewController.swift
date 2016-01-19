//
//  ConcessionsTableViewController.swift
//  ProvidenceWayfinding
//
//  Created by Ruth Manthey on 12/8/15.
//  Copyright © 2015 GU. All rights reserved.
//

import UIKit

class ConcessionsTableViewController: UITableViewController {
    
    // Variables
    var options: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initOptions()
    }
    
    func initOptions()
    {
        options = uniqueCategoryArray(concessions)
        options.sortInPlace()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func uniqueCategoryArray(inputArray: [Concession]!) -> [String]!
    {
        var newArray = [String]()
        for x in inputArray
        {
            /*if(newArray.contains(x.category))
            {
                continue
            }
            else
            {
                newArray.append(x.category)
            }*/
            newArray.append(x.name)
        }
        
        return newArray
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("building1", forIndexPath: indexPath)
        
        // Configure the cell...
        let option = options[indexPath.row]
        cell.textLabel!.text = option + ":"
        cell.detailTextLabel!.text = "11 AM to 8 PM"
        
        return cell
    }
}
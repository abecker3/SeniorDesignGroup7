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
    var options1: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initOptions()
    }
    
    func initOptions()
    {
        options = uniqueCategoryArray(concessions)
        options1 = uniqueCategoryArray1(concessions)
        //options.sortInPlace()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func uniqueCategoryArray(inputArray: [Concession]!) -> [String]!
    {
        var newArray = [String]()
        for x in inputArray
        {
            newArray.append(x.name)
        }
        
        return newArray
    }
    
    func uniqueCategoryArray1(inputArray: [Concession]!) -> [String]!
    {
        var newArray1 = [String]()
        for x in inputArray
        {
            newArray1.append(x.hours)
        }
        
        return newArray1
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("building1", forIndexPath: indexPath)
        
        // Configure the cell...
        let option = options[indexPath.row]
        let option1 = options1[indexPath.row]
        cell.textLabel!.text = option + ":"
        cell.detailTextLabel!.text = option1
        
        return cell
    }
}
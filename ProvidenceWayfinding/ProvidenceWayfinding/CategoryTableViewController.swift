//
//  BuildingTableViewController.swift
//  Test2
//
//  Created by Bilsborough, Michael J on 11/18/15.
//  Copyright © 2015 Gonzaga University. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController{
    
    //Passed in variables
    var passInTextFieldTag: Int!
    
    //Referencing Outlets
    @IBOutlet var buildingTableView: UITableView!
    
    //Variables
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
        let cell = tableView.dequeueReusableCellWithIdentifier("building cell", forIndexPath: indexPath)
        
        // Configure the cell...
        let option = options[indexPath.row]
        cell.textLabel!.text = option
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "buildingToLocation")
        {
            let nextViewController = segue.destinationViewController as! LocationTableViewController
            nextViewController.passInTextFieldTag = self.passInTextFieldTag
            nextViewController.passInCategory = options[buildingTableView.indexPathForSelectedRow!.row]
        }
    }
}

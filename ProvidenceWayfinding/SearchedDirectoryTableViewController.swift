//
//  SearchedDirectoryTableViewController.swift
//  ProvidenceWayfinding
//
//  Created by Ruth Manthey on 2/14/16.
//  Copyright © 2016 GU. All rights reserved.
//

import UIKit

class SearchedDirectoryTableViewController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    @IBOutlet var resultSearchController: UISearchController!
    //@IBOutlet var controllerTitle: UINavigationItem
    var filteredTableData = [String]()
    var options: [String]!
    var passInBuilding: String!
    var allLocationsTag: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //SearchedDirectoryTitle.title = passInBuilding
        initControllerTitle()
        initOptions()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // We are only using one section so we return one
        return 1
    }
    
    func initOptions()
    {
        options = uniqueCategoryArray(directory)
        options.sortInPlace()
    }
    
    func uniqueCategoryArray(inputArray: [Directory]!) -> [String]!
    {
        var newArray = [String]()
        //print(passInBuilding)
        for x in inputArray
        {
            if(x.category == passInBuilding)
            {
                newArray.append(x.name)
            }
            else if (passInBuilding == "All Locations")
            {
                allLocationsTag = true
                if (x.category != "All Locations")
                {
                    newArray.append(x.name)
                }
            }
        }
        return newArray
    }
    
    func initControllerTitle()
    {
        //controllerTitle.title = passInBuilding
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return options.count
    }
    
    /*override func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("building", forIndexPath: indexPath)
    cell.textLabel?.text = options[indexPath.row]
    return cell
    }*/
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("building", forIndexPath: indexPath)
        
        // Configure the cell...
        let option = options[indexPath.row]
        cell.textLabel!.text = option
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "SearchedToSpecific")
        {
            let nextViewController = segue.destinationViewController as! DirectorySpecificViewController
            //nextViewController.passInTextFieldTag = self.passInTextFieldTag
            //let cell = table.dequeueReusableCellWithIdentifier("building", indexPathForSelectedRow)
            let selectedCellPath = table.indexPathForSelectedRow
            //let cell = table.dequeueReusableCellWithIdentifier("building", forIndexPath: selectedCellPath!)
            let cell = table.cellForRowAtIndexPath(selectedCellPath!)
            print(cell!.textLabel?.text)
            nextViewController.passInName = cell!.textLabel?.text
            //nextViewController.passInBuilding = "Children's Hospital"
        }
    }
    
    
    
}

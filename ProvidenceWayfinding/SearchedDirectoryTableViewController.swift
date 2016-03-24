//
//  SearchedDirectoryTableViewController.swift
//  ProvidenceWayfinding
//
//  Created by Ruth Manthey on 2/14/16.
//  Copyright © 2016 GU. All rights reserved.
//

import UIKit

class SearchedDirectoryTableViewController: UITableViewController, UISearchResultsUpdating {
    
    @IBOutlet var table: UITableView!
    //@IBOutlet var resultSearchController: UISearchController!
    @IBOutlet var controllerTitle: UINavigationItem?
    var resultSearchController = UISearchController()
    var filteredTableData = [String]()
    var options: [String]!
    var passInBuilding: String!
    var selectedCellPath: NSIndexPath!
    var allLocationsTag: Bool = false
    var allLocationsClicked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //SearchedDirectoryTitle.title = passInBuilding
        initControllerTitle()
        initOptions()
        
        definesPresentationContext = true
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        
        //Reload table
        self.tableView.reloadData()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredTableData.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        
        var newArray = [String]()
        for x in directory
        {
            newArray.append(x.name)
        }
        
        let array = (newArray as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredTableData = array as! [String]
        
        self.tableView.reloadData()
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
        if(allLocationsTag)
        {
            controllerTitle!.title = "All Locations"
        }
        else {
            controllerTitle!.title = passInBuilding
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //number depends on whether using search bar or just clicking a regular table view cell
        if(resultSearchController.active)
        {
            return self.filteredTableData.count
        }
        return options.count
    }
    
    /*override func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("building", forIndexPath: indexPath)
    cell.textLabel?.text = options[indexPath.row]
    return cell
    }*/
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("building", forIndexPath: indexPath)
        
        /*// Configure the cell...
        let option = options[indexPath.row]
        cell.textLabel!.text = option
        
        return cell*/
        if(self.resultSearchController.active) {
            
            cell.textLabel?.text = filteredTableData[indexPath.row]
            //cell.detailTextLabel!.text = "11 AM to 8 PM"
            return cell
        }
            
        else {
            let option = options[indexPath.row]
            cell.textLabel?.text = option
            //cell.detailTextLabel!.text = "11 AM to 8 PM"
            return cell
        }
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedCellPath = indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextViewController = segue.destinationViewController as! DirectorySpecificViewController
        if (segue.identifier == "SearchedToSpecific" && !resultSearchController.active)
        {
            //nextViewController.passInTextFieldTag = self.passInTextFieldTag
            //let cell = table.dequeueReusableCellWithIdentifier("building", indexPathForSelectedRow)
            let selectedCellPath = table.indexPathForSelectedRow
            //let cell = table.dequeueReusableCellWithIdentifier("building", forIndexPath: selectedCellPath!)
            let cell = table.cellForRowAtIndexPath(selectedCellPath!)
            print(cell!.textLabel?.text)
            nextViewController.passInName = cell!.textLabel?.text
            //nextViewController.passInBuilding = "Children's Hospital"
        }
        else {
            //let selectedCellPath = filteredTableData.indexPathForSelectedRow
            nextViewController.passInName = filteredTableData[table.indexPathForSelectedRow!.row]
        }
    }
    
    
    
}

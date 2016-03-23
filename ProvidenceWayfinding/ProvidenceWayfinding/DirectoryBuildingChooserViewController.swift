//
//  DirectoryBuildingChooserViewController.swift
//  ProvidenceWayfinding
//
//  Created by Ruth Manthey on 2/14/16.
//  Copyright © 2016 GU. All rights reserved.
//

import UIKit

class DirectoryBuildingChooserViewController: UITableViewController/*, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate*/ {
    
    //let controller = UISearchController(searchResultsController: nil)
    
    @IBOutlet var table: UITableView!
    //@IBOutlet var resultSearchController: UISearchController!
    var resultSearchController = UISearchController()
    var filteredTableData = [String]()
    var options: [String]!
    var searchActive: Bool = false
    var allLocationsClicked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Title"
        initOptions()
        
        definesPresentationContext = true
        

        /*controller.searchResultsUpdater = self
        controller.hidesNavigationBarDuringPresentation = false
        controller.dimsBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        self.tableView.tableHeaderView = controller.searchBar*/
        
        /*
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.delegate = self
            //controller.buildingTableView.delegate = self
            
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        
        //Reload table
        self.tableView.reloadData()*/
    }
    
    /*
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        if(!resultSearchController.active)
        {
            return true
        }
        return false
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
        //resultSearchController.active = false
        //searchBarCancelButtonClicked(searchBar)
        //resultSearchController.willDismissSearchController(UISearchController)
        performSegueWithIdentifier("ChooserToSearched", sender: UISearchBar.self)
        print("Worked!")
    }*/
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // We are only using one section so we return one
        return 1
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredTableData.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        
        var newArray = [String]()
        for x in locations
        {
            newArray.append(x.name)
            print(x.name)
        }
        
        //_ = options + newArray
        
        let array = ((options /*+ newArray*/) as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredTableData = array as! [String]
        
        self.tableView.reloadData()
    }
    
    func initOptions()
    {
        options = uniqueCategoryArray(directory)
        //options.append("All Locations")
        options.sortInPlace()
    }
    
    func uniqueCategoryArray(inputArray: [Directory]!) -> [String]!
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
        newArray.append("All Locations")
        return newArray
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
        
        /*//Takes the filtered data and assigns them to the number of rows needed
        if(self.resultSearchController.active) {
            return self.filteredTableData.count
        }
            
            // No searching is going on so the table stays regular using the same number of rows as before
        else {
            return self.options.count
        }*/
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("building", forIndexPath: indexPath)
        
        /*// Configure the cell...
        let option = options[indexPath.row]
        cell.textLabel!.text = option
        
        return cell*/
        
        /*
        if(self.resultSearchController.active) {
            cell.textLabel?.text = filteredTableData[indexPath.row]
            //cell.detailTextLabel!.text = "11 AM to 8 PM"
            return cell
        }
            
        else {
            cell.textLabel?.text = options[indexPath.row]
            //cell.detailTextLabel!.text = "11 AM to 8 PM"
            return cell
        }*/
        
        cell.textLabel?.text = options[indexPath.row]
        //cell.detailTextLabel!.text = "11 AM to 8 PM"
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        /*if (segue.identifier == "ChooserToSearched")
        {
            let nextViewController = segue.destinationViewController as! SearchedDirectoryTableViewController
            //nextViewController.passInTextFieldTag = self.passInTextFieldTag
            //let cell = table.dequeueReusableCellWithIdentifier("building", indexPathForSelectedRow)
            let selectedCellPath = table.indexPathForSelectedRow
            //let cell = table.dequeueReusableCellWithIdentifier("building", forIndexPath: selectedCellPath!)
            let cell = table.cellForRowAtIndexPath(selectedCellPath!)
            print(cell!.textLabel?.text)
            nextViewController.passInBuilding = cell!.textLabel?.text
            //nextViewController.passInBuilding = "Children's Hospital"
            print(nextViewController.passInBuilding)
        }*/
        //let selectedCellPath = table.indexPathForSelectedRow
        //let cell = table.cellForRowAtIndexPath(selectedCellPath!)

        if (segue.identifier == "ChooserToSearched" && !allLocationsClicked /*&& sender === UITableViewCell()*/)
        {
            let nextViewController = segue.destinationViewController as! SearchedDirectoryTableViewController
            //nextViewController.passInTextFieldTag = self.passInTextFieldTag
            nextViewController.passInBuilding = options[table.indexPathForSelectedRow!.row]
        }
            
        else {
            //resultSearchController.active = false
            let nextViewController = segue.destinationViewController as! SearchedDirectoryTableViewController
            //nextViewController.passInTextFieldTag = self.passInTextFieldTag
            nextViewController.allLocationsClicked = true
            nextViewController.passInBuilding = "All Locations"
            nextViewController.allLocationsTag = true
        }

    }

    
}

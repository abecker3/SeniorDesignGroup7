//
//  LocationTableViewController.swift
//  Test2
//
//  Created by Bilsborough, Michael J on 11/19/15.
//  Copyright © 2015 Gonzaga University. All rights reserved.
//

import UIKit

class LocationTableViewController: UITableViewController, UISearchResultsUpdating{
    
    //Passed in variables
    var passInTextFieldTag: Int!
    var passInCategory: String!
    var allLocationsClicked: Bool = false
    
    //Referencing Outlets
    @IBOutlet var locationTableView: UITableView!
    @IBOutlet var controllerTitle: UINavigationItem!
    
    //Variables
    var resultSearchController = UISearchController()
    var filteredTableData = [String]()
    var locationOptions:[Directory] = []
    var locationStringOptions = [String]()
    var allLocationsTag: Bool = false

    override func viewDidLoad()
    {
        super.viewDidLoad()
        //resultSearchController.active = false
        
        //Choose options based on passed in building
        initControllerTitle()
        initOptions()
        
        //definesPresentationContext = true
        
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
        extendedLayoutIncludesOpaqueBars = true; //keeps the search bar from disappearing on tap

    }
    
    override func viewDidAppear(animated: Bool) {
        if(resetToRootView == 1){
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredTableData.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        
        var newArray = [String]()
        for x in locationOptions
        {
            newArray.append(x.name)
        }
        
        //var oldArray = uniqueCategoryArray
        
        let array = (newArray as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredTableData = array as! [String]
        
        filteredTableData.sortInPlace()
        
        self.tableView.reloadData()
    }
    
/*    func uniqueCategoryArray(inputArray: [Location]!) -> [String]!
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
    }*/

    //Populate Table
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return locationOptions.count
        
        //Takes the filtered data and assigns them to the number of rows needed
        if(self.resultSearchController.active) {
            return self.filteredTableData.count
        }
            
            // No searching is going on so the table stays regular using the same number of rows as before
        else {
            return self.locationOptions.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("location cell", forIndexPath: indexPath)

        /*// Configure the cell...
        let option = locationOptions[indexPath.row]
        cell.textLabel!.text = option.name

        return cell*/
        
        if(self.resultSearchController.active) {
            cell.textLabel?.text = filteredTableData[indexPath.row]
            //cell.detailTextLabel!.text = "11 AM to 8 PM"
            return cell
        }
            
        else {
            let option = locationStringOptions[indexPath.row]
            cell.textLabel?.text = option
            //cell.detailTextLabel!.text = "11 AM to 8 PM"
            return cell
        }
    }
    
    //This function checks whether the search bar cell that was clicked is part of Locations
    func checkArrayForMember(tableView: UITableView, indexPath: NSIndexPath) -> Bool
    {
        for x in directory
        {
            if(filteredTableData.count > indexPath.row)
            {
                if(x.name == filteredTableData[indexPath.row])
                {
                    return true
                }
            }
        }
        return false
    }
    
    func getLocationFromName(name: String) -> Directory
    {
        for x in directory{
            if(x.name == name)
            {
                return x
            }
        }
        return Directory(name: "Admitting", category: "Main Tower", floor: "Main", hours: "NA", ext: 0, notes: "")
    }
    
    //Pop back 2 once a row is selected
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let navController = self.navigationController!
        let indexOfLastViewController = navController.viewControllers.count - 1
        let indexOfSurvey = indexOfLastViewController - 2
        let surveyViewController = navController.viewControllers[indexOfSurvey] as! SurveyViewController
    
        if(passInTextFieldTag == surveyViewController.currentTextField.tag && resultSearchController.active && allLocationsTag)
        {
            surveyViewController.currentTextField.placeholder = filteredTableData[indexPath.row]
            let location = getLocationFromName(surveyViewController.currentTextField.placeholder!)
            surveyViewController.startLocation = location
            print(location)
            print("Current: search is active")
        }
        else if(passInTextFieldTag == surveyViewController.destinationTextField.tag && resultSearchController.active && allLocationsTag)
        {
            surveyViewController.destinationTextField.placeholder = filteredTableData[indexPath.row]
            let location = getLocationFromName(surveyViewController.destinationTextField.placeholder!)
            surveyViewController.endLocation = location
            print(location)
            print("Destination: search is active")
        }
        
        /*else if(passInTextFieldTag == surveyViewController.currentTextField.tag )
        {
            surveyViewController.currentTextField.placeholder = filteredTableData[indexPath.row]
            let location = getLocationFromName(surveyViewController.currentTextField.placeholder!)
            surveyViewController.startLocation = location
            print("Current: regular cell selection")
        }
        else if(passInTextFieldTag == surveyViewController.destinationTextField.tag)
        {
            surveyViewController.destinationTextField.placeholder = filteredTableData[indexPath.row]
            let location = getLocationFromName(surveyViewController.currentTextField.placeholder!)
            surveyViewController.endLocation = location
            print("Destination: regular cell selection")
        }*/
        
        else if(passInTextFieldTag == surveyViewController.currentTextField.tag /*&& !allLocationsTag*/)
        {
            surveyViewController.currentTextField.placeholder = locationStringOptions[indexPath.row]
            surveyViewController.startLocation = getLocationFromName(locationStringOptions[indexPath.row])
            print(locationOptions[indexPath.row])
            print("Current: regular cell selection")
        }
        
        else if(passInTextFieldTag == surveyViewController.destinationTextField.tag /*&& !allLocationsTag*/)
        {
            surveyViewController.destinationTextField.placeholder = locationStringOptions[indexPath.row]
            surveyViewController.endLocation = getLocationFromName(locationStringOptions[indexPath.row])
            print(locationOptions[indexPath.row])
            print("Destination: regular cell selection")
        }
        
        resultSearchController.active = false
        navController.popToViewController(surveyViewController, animated: true)
    }
    
    func initOptions()
    {
        for location in directory
        {
            if(location.category == passInCategory && !allLocationsClicked)
            {
                locationOptions.append(location)
                locationStringOptions.append(location.name)
            }
            else if(passInCategory == "All Locations")
            {
                allLocationsTag = true
                if(location.category != "All Locations")
                {
                    locationOptions.append(location)
                    locationStringOptions.append(location.name)
                }
            }
        }
        locationStringOptions.sortInPlace()
    }
    
    func initControllerTitle()
    {
        controllerTitle.title = passInCategory
    }
}

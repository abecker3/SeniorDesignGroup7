//
//  BuildingTableViewController.swift
//  Test2
//
//  Created by Bilsborough, Michael J on 11/18/15.
//  Copyright © 2015 Gonzaga University. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController/*, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate*/{
    
    //Passed in variables
    var passInTextFieldTag: Int!
    
    
    //Referencing Outlets
    @IBOutlet var buildingTableView: UITableView!
    
    //Variables
    var allLocationsClicked: Bool = false
    var resultSearchController = UISearchController()
    var filteredTableData = [String]()
    var options: [String]!
    var locationOptions:[Directory] = []
    var searchActive: Bool = false
    var revisitView: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initOptions()
        
        definesPresentationContext = true
    }
    
    override func viewDidAppear(animated: Bool) {
        if(resetToRootView == 1){
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    /*func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        if(!resultSearchController.active)
        {
            return true
        }
        return false
    }*/
    
    /*func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
        //resultSearchController.active = false
        //searchBarCancelButtonClicked(searchBar)
        //resultSearchController.willDismissSearchController(UISearchController)
        performSegueWithIdentifier("buildingToLocation", sender: UISearchBar.self)
        print("Worked!")
    }*/
    
    /*func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        //performSegueWithIdentifier("buildingToLocation", sender: resultSearchController.searchBar)
        searchActive = true
        resultSearchController.active = false
        //resultSearchController.willDismissSearchController(UISearchController)
        performSegueWithIdentifier("buildingToLocation", sender: UISearchBar.self)
        print("Worked!")
    }*/
    
    //func searchBar(
    
    
    /*func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredTableData.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        
        var newArray = [String]()
        for x in locations
        {
            newArray.append(x.name)
            print(x.name)
        }
                
        let array = ((options /*+ newArray*/) as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredTableData = array as! [String]
        
        self.tableView.reloadData()
    }*/
    
    func initOptions()
    {
        options = uniqueCategoryArray(directory)
        options.append("All Locations")
        options.sortInPlace()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
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
    
/*   //Pop back 1 once a row is selected
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let navController = self.navigationController!
        let indexOfSurvey = navController.viewControllers.count - 1
        let surveyViewController = navController.viewControllers[indexOfSurvey] as! SurveyViewController
        
        if(passInTextFieldTag == surveyViewController.currentTextField.tag)
        {
            surveyViewController.currentTextField.placeholder = locationOptions[indexPath.row].name
            surveyViewController.startLocation = locationOptions[indexPath.row]
        }
        else if(passInTextFieldTag == surveyViewController.destinationTextField.tag)
        {
            surveyViewController.destinationTextField.placeholder = locationOptions[indexPath.row].name
            surveyViewController.endLocation = locationOptions[indexPath.row]
        }
        
        navController.popToViewController(surveyViewController, animated: true)
    }*/
    
    /*override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let navController = self.navigationController!
        let indexOfLocation = navController.viewControllers.count + 1
        let locationViewController = navController.viewControllers[indexOfLocation] as! LocationTableViewController
        
        if(options[indexPath.row] == "All Locations")
        {
            allLocationsClicked = true
        }
    }*/
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "buildingToLocation" && !allLocationsClicked /*&& sender === UITableViewCell()*/)
        {
            let nextViewController = segue.destinationViewController as! LocationTableViewController
            nextViewController.passInTextFieldTag = self.passInTextFieldTag
            nextViewController.passInCategory = options[buildingTableView.indexPathForSelectedRow!.row]
        }
        
        else {
            //resultSearchController.active = false
            let nextViewController = segue.destinationViewController as! LocationTableViewController
            nextViewController.allLocationsClicked = true
            nextViewController.passInTextFieldTag = self.passInTextFieldTag
            nextViewController.passInCategory = "All Locations"
        }
    }
}

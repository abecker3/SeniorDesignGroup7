//
//  BuildingTableViewController.swift
//  Test2
//
//  Created by Bilsborough, Michael J on 11/18/15.
//  Copyright © 2015 Gonzaga University. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate{
    
    //Passed in variables
    var passInTextFieldTag: Int!
    
    //Referencing Outlets
    @IBOutlet var buildingTableView: UITableView!
    
    //Variables
    var resultSearchController = UISearchController()
    var filteredTableData = [String]()
    var options: [String]!
    var locationOptions:[Location] = []
    var searchActive: Bool = false
    var revisitView: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initOptions()
        
        definesPresentationContext = true
        
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
        self.tableView.reloadData()
    }
    
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
        performSegueWithIdentifier("buildingToLocation", sender: UISearchBar.self)
        print("Worked!")
    }
    
    /*func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        //performSegueWithIdentifier("buildingToLocation", sender: resultSearchController.searchBar)
        searchActive = true
        resultSearchController.active = false
        //resultSearchController.willDismissSearchController(UISearchController)
        performSegueWithIdentifier("buildingToLocation", sender: UISearchBar.self)
        print("Worked!")
    }*/
    
    //func searchBar(
    
    
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
        //return options.count
        
        //Takes the filtered data and assigns them to the number of rows needed
        if(self.resultSearchController.active) {
            return self.filteredTableData.count
        }
            
            // No searching is going on so the table stays regular using the same number of rows as before
        else {
            return self.options.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("building cell", forIndexPath: indexPath)
        
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
            cell.textLabel?.text = options[indexPath.row]
            //cell.detailTextLabel!.text = "11 AM to 8 PM"
            return cell
        }
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "buildingToLocation" && !searchActive /*&& sender === UITableViewCell()*/)
        {
            let nextViewController = segue.destinationViewController as! LocationTableViewController
            nextViewController.passInTextFieldTag = self.passInTextFieldTag
            nextViewController.passInCategory = options[buildingTableView.indexPathForSelectedRow!.row]
        }
        
        else {
            //resultSearchController.active = false
            let nextViewController = segue.destinationViewController as! LocationTableViewController
            nextViewController.passInTextFieldTag = self.passInTextFieldTag
            nextViewController.passInCategory = "All Locations"
        }
    }
}

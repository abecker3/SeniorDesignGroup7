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
    
    //Referencing Outlets
    @IBOutlet var locationTableView: UITableView!
    @IBOutlet var controllerTitle: UINavigationItem!
    
    //Variables
    var resultSearchController = UISearchController()
    var filteredTableData = [String]()
    var locationOptions:[Location] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Choose options based on passed in building
        initControllerTitle()
        initOptions()
        
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
        for x in locationOptions
        {
            newArray.append(x.name)
        }
        
        let array = (newArray as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredTableData = array as! [String]
        
        self.tableView.reloadData()
    }

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
            let option = locationOptions[indexPath.row]
            cell.textLabel?.text = option.name
            //cell.detailTextLabel!.text = "11 AM to 8 PM"
            return cell
        }
    }
    
    //Pop back 2 once a row is selected
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let navController = self.navigationController!
        let indexOfLastViewController = navController.viewControllers.count - 1
        let indexOfSurvey = indexOfLastViewController - 2
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
    }
    
    func initOptions()
    {
        for location in locations
        {
            if(location.category == passInCategory)
            {
                locationOptions.append(location)
            }
        }
    }
    
    func initControllerTitle()
    {
        controllerTitle.title = passInCategory
    }
}

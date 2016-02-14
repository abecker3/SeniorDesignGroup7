//
//  DirectoryBuildingChooserViewController.swift
//  ProvidenceWayfinding
//
//  Created by Ruth Manthey on 2/14/16.
//  Copyright © 2016 GU. All rights reserved.
//

import UIKit

class DirectoryBuildingChooserViewController: UITableViewController{
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var label: UILabel!
    //var resultSearchController = UISearchController()
    var filteredTableData = [String]()
    var options: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initOptions()
        
        /*self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()*/
        
        //Reload table
        self.tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // We are only using one section so we return one
        return 1
    }
    
    /*func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredTableData.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (options as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredTableData = array as! [String]
        
        self.tableView.reloadData()
    }*/

    
    func initOptions()
    {
        options = uniqueCategoryArray(directory)
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
            //print(x.category)
            //newArray.append(x.name)
        }
        
        return newArray
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Takes the filtered data and assigns them to the number of rows needed
        /*if(self.resultSearchController.active) {
            return self.filteredTableData.count
        }
            
            // No searching is going on so the table stays regular using the same number of rows as before
        else {
            return self.options.count
        }*/
        return self.options.count
    }
    
    //This function makes sure that if no search is happening the original data is shown
    /*override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("building", forIndexPath: indexPath)
        
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
        //cell.textLabel?.text = filteredTableData[indexPath.row]
        //return cell
    }*/

    
    
}

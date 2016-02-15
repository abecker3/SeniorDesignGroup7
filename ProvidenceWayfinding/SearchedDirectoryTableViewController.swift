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
    var filteredTableData = [String]()
    var options: [String]!
    var passInBuilding: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //SearchedDirectoryTitle.title = passInBuilding
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
        if (passInBuilding == " SEARCH ALL BUILDINGS"){
            for x in inputArray{
                newArray.append(x.name)
            }
        }
        else {
            for x in inputArray
            {
                if(x.category == passInBuilding)
                {
                    newArray.append(x.name)
                }
                else
                {
                    continue
                }
            }
        }
        
        return newArray
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{        return options.count
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

    
}

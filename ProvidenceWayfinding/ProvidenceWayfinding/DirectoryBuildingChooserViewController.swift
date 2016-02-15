//
//  DirectoryBuildingChooserViewController.swift
//  ProvidenceWayfinding
//
//  Created by Ruth Manthey on 2/14/16.
//  Copyright © 2016 GU. All rights reserved.
//

import UIKit

class DirectoryBuildingChooserViewController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    @IBOutlet var resultSearchController: UISearchController!
    var filteredTableData = [String]()
    var options: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Title"
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
        newArray.append(" SEARCH ALL BUILDINGS")
        return newArray
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{        return options.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("building", forIndexPath: indexPath)
        
        // Configure the cell...
        let option = options[indexPath.row]
        cell.textLabel!.text = option
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ChooserToSearched")
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
        }
    }

    
}

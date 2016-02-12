//
//  HistoryViewController.swift
//  ProvidenceWayfinding
//
//  Created by Derek Becker on 2/9/16.
//  Copyright © 2016 GU. All rights reserved.
//

import UIKit

class HistoryViewController: UITableViewController {
    @IBOutlet var table: UITableView!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var maxKeyNum = Int()
    var thisArray = [String()]
    var cellArray = [String()]
    var curIndex = Int()
    var flag = Int()
    var index = 0
    var count = 10
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("historyCell", forIndexPath: indexPath)
        cell.textLabel?.lineBreakMode = .ByWordWrapping
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.text = cellArray[indexPath.item]
        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("Flag: " + String(flag))
        print("curIndex: " + String(curIndex))
        print("Count: " + String(thisArray.count - 1))
        if(flag == 1){
            index = curIndex
        }
        createCellArray()
        table.reloadData()
    }
    
    
    func createCellArray(){
        if (flag == 1){
            var iteration = 0
            while (iteration < 10){
                let location = thisArray[index + 1]
                let date = thisArray[index + 2]
                cellArray.append(String(count) + ": " + location + "on " + date)
                index = (index + 3) % 30
                count = count - 1
                iteration++
            }
        }
        else if (maxKeyNum != 0){
            count = (thisArray.count - 1) / 3
            while (index < thisArray.count - 1){
                let location = thisArray[index + 1]
                let date = thisArray[index + 2]
                cellArray.append(String(count) + ": " + location + "on " + date)
                index = (index + 3) % 30
                count = count - 1
            }
        }
        cellArray = cellArray.reverse()
    }
    
    
}
    /*
@IBOutlet var table: UITableView!

let defaults = NSUserDefaults.standardUserDefaults()
var maxKeyNum = Int()
var thisArray = [String()]
var count = 0
//let myarray = ["item1", "item2", "item3"]

override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
return thisArray.count
}

override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
let cell = tableView.dequeueReusableCellWithIdentifier("historyCell", forIndexPath: indexPath)
cell.textLabel?.text = thisArray[indexPath.item]
return cell
}

override func viewDidAppear(animated: Bool) {
super.viewDidAppear(animated)
table.reloadData()
}

}*/



    /*
    func printArray(){
        while(count != maxKeyNum){
            textView.text = textView.text + thisArray[count]
            textView.text = textView.text + thisArray[count + 1]
            textView.text = textView.text + thisArray[count + 2]
            textView.text = textView.text + "    |    "
            //textView.text = textView.text + thisArray[count]
            //print(thisArray[count])
            count = count + 3
        }
    }
*/
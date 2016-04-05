//
//  DirectorySpecificViewController.swift
//  ProvidenceWayfinding
//
//  Created by Ruth Manthey on 1/26/16.
//  Copyright © 2016 GU. All rights reserved.
//

import UIKit

class DirectorySpecificViewController: UIViewController {
    @IBOutlet weak var floorMap: UIImageView!
    @IBOutlet weak var scrollMap: UIScrollView!
    @IBOutlet weak var directorySpecificTitle: UINavigationItem!

    var passInName: String!
    var phoneExt: Int!
    var hours: String!
    var building: String!
    var floor: String!
    var thisFloor = String()
    var fileExtension = String()
    var allLocationsClicked: Bool = false
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var floorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        nameLabel.text = passInName
        getInfoFromName(directory)
        directorySpecificTitle.title = passInName
        phoneLabel.text = String(phoneExt)
        hoursLabel.text = hours
        buildingLabel.text = building
        floorLabel.text = floor
    }
    
    func getInfoFromName(inputArray: [Directory]!) -> [String]!
    {
        var newArray = [String]()
        for x in inputArray
        {
            if(x.name == passInName)
            {
                newArray.append(x.name)
                phoneExt = x.ext
                hours = x.hours
                building = x.category
                floor = x.floor
            }
        }
        return newArray
    }
    
    @IBAction func takeMeHere(sender: AnyObject) {
        routeFromWhichScreen = 2
        flagForPlace = 1
        directoryEntry = Directory(name: passInName, category: building, floor: floor, hours: hours, ext: phoneExt)
        tabBarController?.selectedIndex = 1
    }
    

}

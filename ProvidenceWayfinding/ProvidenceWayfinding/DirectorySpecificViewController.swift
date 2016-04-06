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
    var notes: String!
    var thisFloor = String()
    var fileExtension = String()
    var allLocationsClicked: Bool = false
    var phoneNumber = String()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var floorLabel: UILabel!
    @IBOutlet var notesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        nameLabel.text = passInName
        getInfoFromName(directory)
        directorySpecificTitle.title = passInName
        phoneLabel.text = String(phoneExt)
        //[UIApplication, sharedApplication], openURL,[NSURL, URLWithString,"telprompt:5094743131"];
        hoursLabel.text = hours
        buildingLabel.text = building
        floorLabel.text = floor
        notesLabel.text = notes
        //phoneLabel.text =
        fileExtension = ".jpg"
        
        //setMap()
    }
    
    func setMap(){
        switch building{
        case "Children's Hospital": thisFloor = "Childrens_" + floor + fileExtension
        case "Main Tower": thisFloor = "Main_" + floor + fileExtension
        case "Women's Health Center": thisFloor = "Womens_" + floor + fileExtension
        case "Heart Institute": thisFloor = "Heart_" + floor + fileExtension
        default: "NotAvailable.jpg"
        }
        
        //floorMap.image = UIImage(named: thisFloor)
        //floorMap.contentMode = UIViewContentMode.ScaleAspectFit
        
        self.scrollMap.maximumZoomScale = 5.0
        self.scrollMap.clipsToBounds = true
    }
    
    private func callNumber(phoneNumber:String) {
        let phoneNumber = "5094743131" + phoneLabel.text!
        if let phoneCallURL:NSURL = NSURL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
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
                notes = x.notes
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

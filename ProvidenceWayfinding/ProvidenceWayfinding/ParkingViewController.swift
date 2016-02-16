//
//  ParkingViewController.swift
//  ProvidenceWayfinding
//
//  Created by Bilsborough, Michael J and Becker, Andrew D on 11/10/15.
//  Copyright © 2015 GU. All rights reserved.
//

import UIKit
import Foundation

class ParkingViewController: UIViewController, UITextFieldDelegate{
    var screenEdgeRecognizerLeft: UIScreenEdgePanGestureRecognizer!
    var screenEdgeRecognizerRight: UIScreenEdgePanGestureRecognizer!
    var flag = 0
    var theseSpots = [String()]
    var keyNum = Int()
    var indexFlag = Int()
    
    //Variables
    var endLocation: Location!
    var startLocation: Location!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let dateFormatter: NSDateFormatter = {
        let df = NSDateFormatter();
        df.dateStyle = NSDateFormatterStyle.ShortStyle;
        return df;
    }()

    
    //Outlets
    @IBOutlet weak var savedParkingSpot: UILabel!
    @IBOutlet weak var savedParkingDate: UILabel!
    @IBOutlet weak var buildingButtons: UISegmentedControl!
    @IBOutlet weak var floorButtons: UISegmentedControl!
    @IBOutlet weak var elevatorButtons: UISegmentedControl!
    
    var parkingLocationBuilding = String()
    var parkingLocationFloor = String()
    var parkingLocationElevator = String()
    var parkingLocation = String()
    var pathFlag = Int()
    
    //Actions
    @IBAction func save(sender: AnyObject) {
        parkingLocation = parkingLocationBuilding + "Floor " + parkingLocationFloor + "using the " + parkingLocationElevator
        if (indexFlag == 0){
            theseSpots.insert(String(keyNum), atIndex: keyNum)
            theseSpots.insert(parkingLocation, atIndex: keyNum + 1)
            theseSpots.insert(dateFormatter.stringFromDate(NSDate()), atIndex: keyNum + 2)
        }
        else{
            theseSpots[keyNum] = String(keyNum)
            theseSpots[keyNum + 1] = parkingLocation
            theseSpots[keyNum + 2] = dateFormatter.stringFromDate(NSDate())
        }
        defaults.setObject(theseSpots, forKey: "parkingArray");
        if(keyNum + 3 >= 30){
            indexFlag = 1
        }
        keyNum = (keyNum + 3) % 30
        defaults.setObject(keyNum, forKey: "keyNum")
        defaults.setObject(indexFlag, forKey: "indexFlag")
        defaults.synchronize();
        savedParkingSpot.text = parkingLocation;
        savedParkingDate.text = dateFormatter.stringFromDate(NSDate());
    }
    
    @IBAction func changedBuilding(sender: UISegmentedControl) {
        let title = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)
        switch title{
        case "Main"?: parkingLocationBuilding = "Main Tower "
        case "Children's"?: parkingLocationBuilding = "Children's Hospital "
        case "Women's"?: parkingLocationBuilding = "Women's Health Institute "
        default: parkingLocationBuilding = "Heart Institute "
        }
    }
    
    @IBAction func changedFloor(sender: UISegmentedControl) {
        let title = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)
        switch title{
        case "L6"?: parkingLocationFloor = "L6 "
        case "L5"?: parkingLocationFloor = "L5 "
        case "L4"?: parkingLocationFloor = "L4 "
        case "UL4"?: parkingLocationFloor = "UL4 "
        case "L3"?: parkingLocationFloor = "L3 "
        case "L2"?: parkingLocationFloor = "L2 "
        case "L1"?: parkingLocationFloor = "L1 "
        default: parkingLocationFloor = "N/A "
        }
    }
    
    @IBAction func changedElevator(sender: UISegmentedControl) {
        let title = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)
        switch title{
        case "Main"?: parkingLocationElevator = "Main Elevator "
        case "Star"?: parkingLocationElevator = "Star Elevator "
        case "Fish"?: parkingLocationElevator = "Fish Elevator "
        case "Women's"?: parkingLocationElevator = "Women's Health Elevator "
        default: parkingLocationElevator = "Heart Institute Elevator "
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenEdgeRecognizerRight = UIScreenEdgePanGestureRecognizer(target: self, action: "switchScreenGestureRight:")
        screenEdgeRecognizerRight.edges = .Right
        view.addGestureRecognizer(screenEdgeRecognizerRight)
        
        screenEdgeRecognizerLeft = UIScreenEdgePanGestureRecognizer(target: self, action: "switchScreenGestureLeft:")
        screenEdgeRecognizerLeft.edges = .Left
        view.addGestureRecognizer(screenEdgeRecognizerLeft)
        
        // Do any additional setup after loading the view.
        parkingLocationBuilding = "Main Tower "
        parkingLocationElevator = "Main Elevator "
        parkingLocationFloor = "L6 "
    }
    
    override func viewDidAppear(animated: Bool) {
        //Load Saved Parking Spot/Date
        pathFlag = 0
        defaults.setObject(pathFlag, forKey: "pathFlag")
        
        if(defaults.stringForKey("keyNum") != nil){
            keyNum = Int(defaults.stringForKey("keyNum")!)!
        }
        else{ keyNum = 0 }
        if(defaults.stringForKey("indexFlag") != nil && defaults.stringForKey("indexFlag") != String(0)){
            indexFlag = Int(defaults.stringForKey("indexFlag")!)!
        }
        else{ indexFlag = 0 }
        if (indexFlag == 1){
            if (keyNum != 0){
                theseSpots = defaults.objectForKey("parkingArray")! as! NSArray as! [String]
                savedParkingSpot.text = theseSpots[keyNum - 2]
                savedParkingDate.text = theseSpots[keyNum - 1]
            }
            else{
                theseSpots = defaults.objectForKey("parkingArray")! as! NSArray as! [String]
                savedParkingSpot.text = theseSpots[28]
                savedParkingDate.text = theseSpots[29]
            }
        }
        else if (keyNum != 0){
            theseSpots = defaults.objectForKey("parkingArray")! as! NSArray as! [String]
            savedParkingSpot.text = theseSpots[keyNum - 2]
            savedParkingDate.text = theseSpots[keyNum - 1]
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextViewController = segue.destinationViewController as! HistoryViewController
        if (indexFlag == 1){
            nextViewController.maxKeyNum = 30
            nextViewController.curIndex = keyNum
            nextViewController.flag = indexFlag
        }
        else{
            nextViewController.maxKeyNum = keyNum
            nextViewController.flag = indexFlag
        }
        nextViewController.thisArray = theseSpots
    }
    
    func switchScreenGestureRight(sender: UIScreenEdgePanGestureRecognizer) {
        flag = flag + 1
        if (flag % 2 == 1){
            tabBarController?.selectedIndex = 3
        }
    }
    
    func switchScreenGestureLeft(sender: UIScreenEdgePanGestureRecognizer) {
        flag = flag + 1
        if (flag % 2 == 1){
            tabBarController?.selectedIndex = 1
        }
    }
}

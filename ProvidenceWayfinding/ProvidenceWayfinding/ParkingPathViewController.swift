//
//  ParkingPathViewController.swift
//  ProvidenceWayfinding
//
//  Created by Derek Becker on 2/9/16.
//  Copyright © 2016 GU. All rights reserved.
//

import UIKit
import Foundation

class ParkingPathViewController: UIViewController, UITextFieldDelegate {

    var screenEdgeRecognizerRight: UIScreenEdgePanGestureRecognizer!
    var flag = 0
    //var theseSpots = [String()]
    var building = [String()]
    var floor =  [String()]
    var dateSave = [String()]
    var timeSave = [String()]
    var keyNum = Int()
    var indexFlag = Int()
    
    //Variables
    var endLocation: Location!
    var startLocation: Location!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let dateFormatter: NSDateFormatter = {
        let df = NSDateFormatter();
        df.dateStyle = NSDateFormatterStyle.MediumStyle;
        return df;
    }()
    
    
    //Outlets
    @IBOutlet weak var savedParkingTime: UILabel!
    @IBOutlet weak var savedParkingFloor: UILabel!
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
            /*
            theseSpots.insert(String(keyNum), atIndex: keyNum)
            theseSpots.insert(parkingLocation, atIndex: keyNum + 1)
            theseSpots.insert(dateFormatter.stringFromDate(NSDate()), atIndex: keyNum + 2)
*/
            building.insert(parkingLocationBuilding, atIndex: 0)
            floor.insert("Floor: "+parkingLocationFloor, atIndex: 0)
            dateSave.insert(dateFormatter.stringFromDate(NSDate()), atIndex: 0)
            dateFormatter.dateFormat = "h:mm a"
            timeSave.insert(dateFormatter.stringFromDate(NSDate()) , atIndex: 0)
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle;
        }
        else{
            /*theseSpots[keyNum] = String(keyNum)
            theseSpots[keyNum + 1] = parkingLocation
            theseSpots[keyNum + 2] = dateFormatter.stringFromDate(NSDate())*/
            building.insert(parkingLocationBuilding, atIndex: 0)
            floor.insert("Floor: "+parkingLocationFloor, atIndex: 0)
            dateSave.insert(dateFormatter.stringFromDate(NSDate()), atIndex: 0)
            dateFormatter.dateFormat = "h:mm a"
            timeSave.insert(dateFormatter.stringFromDate(NSDate()) , atIndex: 0)
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle;
            building.removeLast()
            floor.removeLast()
            timeSave.removeLast()
            dateSave.removeLast()
        }
        defaults.setObject(building, forKey: "buildingArray")
        defaults.setObject(floor, forKey: "floorArray")
        defaults.setObject(timeSave, forKey: "timeArray")
        defaults.setObject(dateSave, forKey: "dateArray")
        if(keyNum >= 8){
            indexFlag = 1
            keyNum = 0
        }else{
            keyNum += 1
        }
        /*defaults.setObject(theseSpots, forKey: "parkingArray");
        if(keyNum + 3 >= 30){
            indexFlag = 1
        }
        keyNum = (keyNum + 3) % 30*/
        defaults.setObject(keyNum, forKey: "keyNum")
        defaults.setObject(indexFlag, forKey: "indexFlag")
        defaults.synchronize();
        savedParkingSpot.text = building[0]
        savedParkingDate.text = dateSave[0]
        savedParkingFloor.text = floor[0]
        savedParkingTime.text = timeSave[0]
    }
    
    @IBAction func changedBuilding(sender: UISegmentedControl) {
        let title = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)
        switch title{
        case "Main"?: parkingLocationBuilding = "Main Tower "
        case "Children's"?: parkingLocationBuilding = "Children's Hospital "
        case "Women's"?: parkingLocationBuilding = "Women's Health Center "
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
        
        // Do any additional setup after loading the view.
        parkingLocationBuilding = "Main Tower "
        parkingLocationElevator = "Main Elevator "
        parkingLocationFloor = "L6 "
    }
    
    override func viewDidAppear(animated: Bool) {
        //Load Saved Parking Spot/Date
        pathFlag = 1
        defaults.setObject(pathFlag, forKey: "pathFlag")
        
        if(defaults.stringForKey("keyNum") != nil){
            keyNum = Int(defaults.stringForKey("keyNum")!)!
        }
        else{ keyNum = 0 }
        if(defaults.stringForKey("indexFlag") != nil && defaults.stringForKey("indexFlag") != String(0)){
            indexFlag = Int(defaults.stringForKey("indexFlag")!)!
        }
        else{ indexFlag = 0 }
        if (keyNum != 0){
            building = defaults.objectForKey("buildingArray")! as! NSArray as! [String]
            floor = defaults.objectForKey("floorArray")! as! NSArray as! [String]
            timeSave = defaults.objectForKey("timeArray")! as! NSArray as! [String]
            dateSave = defaults.objectForKey("dateArray")! as! NSArray as! [String]
        }
        
        savedParkingSpot.text = building[0]
        savedParkingDate.text = dateSave[0]
        savedParkingFloor.text = floor[0]
        savedParkingTime.text = timeSave[0]

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextViewController = segue.destinationViewController as! OnCampusViewController
        nextViewController.startLocation = self.startLocation
        nextViewController.endLocation = self.endLocation
    }
    
    func switchScreenGestureRight(sender: UIScreenEdgePanGestureRecognizer) {
        flag = flag + 1
        if (flag % 2 == 1){
            performSegueWithIdentifier("onCampusView", sender: nil)
        }
    }
}
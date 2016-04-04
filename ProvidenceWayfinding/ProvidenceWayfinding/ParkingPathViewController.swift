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
    var building = [String()]
    var floor =  [String()]
    var dateSave = [String()]
    var timeSave = [String()]
    var keyNum = Int()
    var indexFlag = Int()
    var saved = false
    
    //Variables
    var endLocation: Directory!
    var startLocation: Directory!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let dateFormatter: NSDateFormatter = {
        let df = NSDateFormatter();
        df.dateStyle = NSDateFormatterStyle.MediumStyle;
        return df;
    }()
    
    
    //Outlets
    @IBOutlet weak var nextBut: UIBarButtonItem!
    @IBOutlet weak var parkView: UIView!
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
    @IBAction func nextView(sender: AnyObject) {
        if (saved == false){
            let alertTitle = "Caution!"
            let alertMessage = "Would you like to continue without saving your most current parking location?"
            let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in
                self.performSegueWithIdentifier("onCampusView", sender: self)
            }))
            alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in
                alertController.dismissViewControllerAnimated(true, completion: nil)
            }))
            
            presentViewController(alertController, animated: false, completion: nil)
        }else{
            self.performSegueWithIdentifier("onCampusView", sender: self)
            
        }

    }
    @IBAction func save(sender: AnyObject) {
        parkingLocation = parkingLocationBuilding + "Floor " + parkingLocationFloor + "using the " + parkingLocationElevator
        if (indexFlag == 0){

            building.insert(parkingLocationBuilding, atIndex: 0)
            floor.insert("Floor: "+parkingLocationFloor, atIndex: 0)
            dateSave.insert(dateFormatter.stringFromDate(NSDate()), atIndex: 0)
            dateFormatter.dateFormat = "h:mm a"
            timeSave.insert(dateFormatter.stringFromDate(NSDate()) , atIndex: 0)
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle;
        }
        else{

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

        defaults.setObject(keyNum, forKey: "keyNum")
        defaults.setObject(indexFlag, forKey: "indexFlag")
        defaults.synchronize();
        savedParkingSpot.text = building[0]
        savedParkingDate.text = dateSave[0]
        savedParkingFloor.text = floor[0]
        savedParkingTime.text = timeSave[0]
        saved = true
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
        parkView.layer.borderWidth = 2
        parkView.layer.cornerRadius = 10
        parkView.layer.borderColor = UIColor(red: 6/255.0, green: 56/255.0, blue: 122/255.0, alpha: 1.0).CGColor
        
        //screenEdgeRecognizerRight = UIScreenEdgePanGestureRecognizer(target: self, action: "switchScreenGestureRight:")
        //screenEdgeRecognizerRight.edges = .Right
        //view.addGestureRecognizer(screenEdgeRecognizerRight)
        
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

        if (defaults.objectForKey("buildingArray") != nil){
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
    
    /*override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "onCampusView"{
            if (saved == false){
                let alertTitle = "Caution!"
                let alertMessage = "Would you like to continue without saving your most current parking location?"
                let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in
                    return true
                }))
                alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in
                    return false
                    }))
                
                presentViewController(alertController, animated: false, completion: nil)
            }else{
                return true
            
            }
        }
        return true //by default
    }*/
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextViewController = segue.destinationViewController as! OnCampusViewController
        nextViewController.startLocation = self.startLocation
        nextViewController.endLocation = self.endLocation
        
    }
    /*
    func switchScreenGestureRight(sender: UIScreenEdgePanGestureRecognizer) {
        flag = flag + 1
        if (flag % 2 == 1){
            performSegueWithIdentifier("onCampusView", sender: nil)
        }
    }*/
}
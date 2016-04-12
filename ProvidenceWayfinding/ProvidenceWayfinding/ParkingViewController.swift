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
    var building = [String()]
    var floor =  [String()]
    var dateSave = [String()]
    var timeSave = [String()]
    var keyNum = Int()
    var indexFlag = Int()
    var buttonFlag = 0
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
    @IBOutlet weak var parkView: UIView!
    @IBOutlet weak var savedParkingTime: UILabel!
    @IBOutlet weak var savedParkingFloor: UILabel!
    @IBOutlet weak var savedParkingSpot: UILabel!
    @IBOutlet weak var savedParkingDate: UILabel!
    @IBOutlet weak var buildingButtons: UISegmentedControl!
    @IBOutlet weak var floorButtons: UISegmentedControl!
    
    var parkingLocationBuilding = String()
    var parkingLocationFloor = String()
    var parkingLocation = String()
    var pathFlag = Int()
    
    //Actions
    @IBAction func save(sender: AnyObject) {

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
        
        parkingEntry = Directory(name: building[0], category: "Parking", floor: floor[0], hours: "NA", ext: 0, notes: "")

    }
    
    @IBAction func changedBuilding(sender: UISegmentedControl) {
        let title = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)
        switch title{
        case "Doctors"?: parkingLocationBuilding = "Doctors Building "
                        setFloorOptions(0)
        case "Children's"?: parkingLocationBuilding = "Children's Hospital "
                        setFloorOptions(1)
        case "Women's"?: parkingLocationBuilding = "Women's Health Center "
                        setFloorOptions(2)
        default: parkingLocationBuilding = "Heart Institute "
                        setFloorOptions(3)
        }
    }
    
    func setFloorOptions(x: Int){
        turnButtons(0, function: 1)
        switch x{
        case 1: floorButtons.setTitle("L6", forSegmentAtIndex: 0)
                floorButtons.setTitle("L5", forSegmentAtIndex: 1)
                floorButtons.setTitle("L4", forSegmentAtIndex: 2)
                floorButtons.setTitle("UL4", forSegmentAtIndex:3)
                floorButtons.setTitle("L3", forSegmentAtIndex: 4)
                turnButtons(4,function: 0)
                parkingLocationFloor = "L6"
                floorButtons.selectedSegmentIndex = 0
        case 2: floorButtons.setTitle("P2", forSegmentAtIndex: 0)
                floorButtons.setTitle("P3", forSegmentAtIndex: 1)
                floorButtons.setTitle("P4", forSegmentAtIndex: 2)
                floorButtons.setTitle("P5", forSegmentAtIndex: 3)
                turnButtons(3,function: 0)
                turnButtons(4,function: 1)
                parkingLocationFloor = "P2"
                floorButtons.selectedSegmentIndex = 0
        case 3: floorButtons.setTitle("P1", forSegmentAtIndex: 0)
                floorButtons.setTitle("P2", forSegmentAtIndex: 1)
                floorButtons.setTitle("P3", forSegmentAtIndex: 2)
                floorButtons.setTitle("P4", forSegmentAtIndex: 3)
                floorButtons.setTitle("P5", forSegmentAtIndex: 4)
                turnButtons(4,function: 0)
                turnButtons(5,function: 1)
                parkingLocationFloor = "P1"
                floorButtons.selectedSegmentIndex = 0
        default:floorButtons.setTitle("C", forSegmentAtIndex: 0)
                floorButtons.setTitle("D", forSegmentAtIndex: 1)
                floorButtons.setTitle("E", forSegmentAtIndex: 2)
                floorButtons.setTitle("F", forSegmentAtIndex: 3)
                floorButtons.setTitle("5", forSegmentAtIndex: 4)
                floorButtons.setTitle("6", forSegmentAtIndex: 5)
                floorButtons.setTitle("7", forSegmentAtIndex: 6)
                turnButtons(6,function: 0)
                turnButtons(7,function: 1)
                parkingLocationFloor = "C"
                floorButtons.selectedSegmentIndex = 0
        }
    }
    
    func turnButtons(var amount: Int, function: Int){
        if function == 0{
            while amount > -1 {
                floorButtons.setEnabled(true, forSegmentAtIndex: amount)
                amount--
            }
        }
        else{
            while amount < 7 {
                floorButtons.setEnabled(false, forSegmentAtIndex: amount)
                floorButtons.setTitle("", forSegmentAtIndex: amount)
                amount++
            }
        }
    }
    
    @IBAction func changedFloor(sender: UISegmentedControl) {
        parkingLocationFloor = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parkView.layer.borderWidth = 2
        parkView.layer.cornerRadius = 10
        parkView.layer.borderColor = UIColor(red: 6/255.0, green: 56/255.0, blue: 122/255.0, alpha: 1.0).CGColor
        screenEdgeRecognizerRight = UIScreenEdgePanGestureRecognizer(target: self, action: "switchScreenGestureRight:")
        screenEdgeRecognizerRight.edges = .Right
        view.addGestureRecognizer(screenEdgeRecognizerRight)
        
        screenEdgeRecognizerLeft = UIScreenEdgePanGestureRecognizer(target: self, action: "switchScreenGestureLeft:")
        screenEdgeRecognizerLeft.edges = .Left
        view.addGestureRecognizer(screenEdgeRecognizerLeft)
        
        // Do any additional setup after loading the view.
        parkingLocationBuilding = "Doctors Building"
        parkingLocationFloor = "C"
        
        setFloorOptions(0)
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
        
        parkingEntry = Directory(name: building[0], category: "Parking", floor: floor[0], hours: "NA", ext: 0, notes: "")

    }

    @IBAction func routeToCar(sender: AnyObject) {
        routeFromWhichScreen = 1
        flagForPlace = 1
        tabBarController?.selectedIndex = 1
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (sender!.tag == 1){
            let nextViewController = segue.destinationViewController as! HistoryViewController
            if (indexFlag == 1){
                nextViewController.curIndex = keyNum
                nextViewController.flag = indexFlag
            }
            else{
                nextViewController.flag = indexFlag
            }
            nextViewController.building = building
            nextViewController.floor = floor
            nextViewController.dateSave = dateSave
            nextViewController.timeSave = timeSave
        }
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

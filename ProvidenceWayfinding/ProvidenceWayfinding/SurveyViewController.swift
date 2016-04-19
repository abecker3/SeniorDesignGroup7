//
//  SurveyViewController.swift
//  Test2
//
//  Created by Bilsborough, Michael J on 11/22/15.
//  Copyright © 2015 Gonzaga University. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController, UITextFieldDelegate{
    
    var screenEdgeRecognizerLeft: UIScreenEdgePanGestureRecognizer!
    var screenEdgeRecognizerRight: UIScreenEdgePanGestureRecognizer!
    var flag = 0
    
    //Referencing Outlets
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var currentTextField: UITextField!
    @IBOutlet var destinationTextField: UITextField!
    
    //Variables
    var passOutTextFieldTag: Int!
    var startLocation: Directory!
    var endLocation: Directory!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenEdgeRecognizerLeft = UIScreenEdgePanGestureRecognizer(target: self, action: "switchScreenGestureLeft:")
        screenEdgeRecognizerLeft.edges = .Left
        view.addGestureRecognizer(screenEdgeRecognizerLeft)
        
        screenEdgeRecognizerRight = UIScreenEdgePanGestureRecognizer(target: self, action: "switchScreenGestureRight:")
        screenEdgeRecognizerRight.edges = .Right
        view.addGestureRecognizer(screenEdgeRecognizerRight)
        
        //Delegates
        currentTextField.delegate = self
        destinationTextField.delegate = self
        
        //Tags
        currentTextField.tag = 0
        destinationTextField.tag = 1
        
        if (routeFromWhichScreen == 0){
            startLocation = Directory(name: "Off Campus", category: "NA", floor: "NA", hours: "NA", ext: 0, notes: "")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        resetToRootView = 0
        //From Parking
        if (routeFromWhichScreen == 1){
            if (flagForPlace == 1){
                setPlaceHolder()
            }
            segmentedControl.selectedSegmentIndex = 1
            destinationTextField.placeholder = parkingEntry.name + "Parking"
            endLocation = parkingEntry
            routeFromWhichScreen = 0
        }
            //From Directory
        else if (routeFromWhichScreen == 2){
            if (flagForPlace == 1){
                clearPlaceHolder()
            }
            segmentedControl.selectedSegmentIndex = 0
            destinationTextField.placeholder = directoryEntry.name
            endLocation = directoryEntry
            routeFromWhichScreen = 0
        }
        //From Parking History
        else if (routeFromWhichScreen == 3){
            if (flagForPlace == 1){
                setPlaceHolder()
            }
            segmentedControl.selectedSegmentIndex = 1
            destinationTextField.placeholder = parkingHistEntry.name + "Parking"
            endLocation = parkingHistEntry
            routeFromWhichScreen = 0
        }
    }
    
    func setPlaceHolder(){
        currentTextField.placeholder = "Select Current Location"
        currentTextField.enabled = true
        startLocation = nil
        flagForPlace = 0
    }
    
    func clearPlaceHolder(){
        currentTextField.placeholder = "Off Campus"
        currentTextField.enabled = false
        startLocation = Directory(name: "Off Campus", category: "NA", floor: "NA", hours: "NA", ext: 0, notes: "")
        flagForPlace = 0
    }
    
    @IBAction func changedOnOff(sender: UISegmentedControl) {
        let title = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)
        if(title == "Off Campus")
        {
            currentTextField.placeholder = "Off Campus"
            currentTextField.enabled = false
            startLocation = Directory(name: "Off Campus", category: "NA", floor: "NA", hours: "NA", ext: 0, notes: "")
        }
        else if(title == "On Campus")
        {
            currentTextField.placeholder = "Select Current Location"
            currentTextField.enabled = true
            startLocation = nil
        }
    }
    
    
    //Transition to Building View Controller when either text field is selected
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if(textField == currentTextField)
        {
            passOutTextFieldTag = currentTextField.tag
        }
        else if(textField == destinationTextField)
        {
            passOutTextFieldTag = destinationTextField.tag
        }
        performSegueWithIdentifier("surveyToBuilding", sender: nil)
        return false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "surveyToBuilding")
        {
            let nextViewController = segue.destinationViewController as! CategoryTableViewController;
            nextViewController.passInTextFieldTag = passOutTextFieldTag
        }
        else if (segue.identifier == "surveyToMap")
        {
            let nextViewController = segue.destinationViewController as! DirectionsViewController;
            nextViewController.startLocation = self.startLocation
            nextViewController.endLocation = self.endLocation
        }
        else if (segue.identifier == "surveyToCampus")
        {
            let nextViewController = segue.destinationViewController as! OnCampusDirectionsViewController;
            nextViewController.startLocation = self.startLocation
            nextViewController.endLocation = self.endLocation
        }
        
    }
    
    @IBAction func routeNowEvent(sender: AnyObject) {
        
        if(startLocation != nil && endLocation != nil && startLocation.name != endLocation.name)
        {
            if(startLocation.name == "Off Campus")
            {
                performSegueWithIdentifier("surveyToMap", sender: self)
            }
            else
            {
                performSegueWithIdentifier("surveyToCampus", sender: self)
            }
        }
        else
        {
            let alertTitle = "Error"
            let alertMessage = "Please select your current location and destination"
            let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func switchScreenGestureRight(sender: UIScreenEdgePanGestureRecognizer) {
        flag = flag + 1
        if (flag % 2 == 1){
            tabBarController?.selectedIndex = 2
        }
    }
    
    func switchScreenGestureLeft(sender: UIScreenEdgePanGestureRecognizer) {
        flag = flag + 1
        if (flag % 2 == 1){
            tabBarController?.selectedIndex = 0
        }
    }
    
}

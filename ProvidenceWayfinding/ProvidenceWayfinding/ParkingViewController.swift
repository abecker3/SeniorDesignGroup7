//
//  ParkingViewController.swift
//  ProvidenceWayfinding
//
//  Created by Bilsborough, Michael J on 11/10/15.
//  Copyright © 2015 GU. All rights reserved.
//

import UIKit
import Foundation

class ParkingViewController: UIViewController, UITextFieldDelegate {
    
    //Variables
    let defaults = NSUserDefaults.standardUserDefaults()
    let dateFormatter: NSDateFormatter = {
        let df = NSDateFormatter();
        df.dateStyle = NSDateFormatterStyle.ShortStyle;
        return df;
    }()

    
    //Outlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var savedParkingSpot: UILabel!
    @IBOutlet weak var savedParkingDate: UILabel!
    
    //Actions
    @IBAction func save(sender: AnyObject) {
        defaults.setObject(textField.text, forKey: "savedParkingSpot");
        defaults.setObject(dateFormatter.stringFromDate(NSDate()), forKey: "savedParkingDate");
        defaults.synchronize();
        savedParkingSpot.text = textField.text;
        savedParkingDate.text = dateFormatter.stringFromDate(NSDate());
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Load Saved Parking Spot/Date
        savedParkingSpot.text = defaults.stringForKey("savedParkingSpot");
        savedParkingDate.text = defaults.stringForKey("savedParkingDate");
        self.textField.delegate = self;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

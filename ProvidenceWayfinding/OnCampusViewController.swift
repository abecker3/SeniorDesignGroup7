//
//  OnCampusViewController.swift
//  ProvidenceWayfinding
//
//  Created by Becker, Andrew D on 11/3/15.
//  Copyright © 2015 GU. All rights reserved.
//

import UIKit

class OnCampusViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIScrollViewDelegate{
    @IBOutlet weak var scrollMap: UIScrollView!
    @IBOutlet weak var floorMap: UIImageView!
    @IBOutlet weak var picker: UIPickerView!
    
    var pickerData: [[String]] = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        floorMap.image = UIImage(named:"Campus.jpg")
        floorMap.contentMode = UIViewContentMode.ScaleAspectFit
        
        self.scrollMap.maximumZoomScale = 5.0
        self.scrollMap.clipsToBounds = true
        
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        
        // Input data into the Array:
        pickerData = [["None","Children Emergency", "Bone/Joint", "Cardiac", "Gynecology", "Fetal-Medicine", "Item 6"],
                    ["None","Floor 1","Floor 2","Floor 3","Floor 4"]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    // Catpure the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.floorMap
    }
    
}
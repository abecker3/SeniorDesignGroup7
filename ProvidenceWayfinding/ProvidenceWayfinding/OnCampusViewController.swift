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

        floorMap.image = UIImage(named:"Floor_1.jpg")
        floorMap.contentMode = UIViewContentMode.ScaleAspectFit
        
        self.scrollMap.maximumZoomScale = 5.0
        self.scrollMap.clipsToBounds = true
        
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        
        // Input data into the Array:
        pickerData = [["None","Adult Psychiatry"," Birth Place", "Child Psychiatry","Emergency","ICU",
                        "ICU Cardiac","ICU Neonatal","ICU Neuro","ICU Pediatrics","Maternity",
                        "Medical Records","Pediatric Oncology","Pediatric Unit","Radiation Oncology","Radiology",
                        "Surgery","Surgery Pediatric"],
                    ["None","Lower Levels","Floor 1","Floor 2","Floor 3"]]
        /*
        Floor 1:    ["Medical Records","Adult Psychiatry","Surgery","Maternity",
        Floor 2:    "Birth Place","ICU Cardiac","ICU","ICU Neuro","Child Psychiatry",
        Floor 3:    "ICU Pediactric","Pediactric Unit","ICU Neonatal","Pediatric Oncology",
        LL1:        "Emergency","Surgery Pediatric","Radiology"
        LL3:        "Radiation Oncology"]    = 17
        */
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
        if component == 1{
            //This is if the user chooses a specific floor
            if (row == 1){floorMap.image = UIImage(named:"LowerLevels.jpg")}
            else if (row == 2){floorMap.image = UIImage(named:"Floor_1.jpg")}
            else if (row == 3){floorMap.image = UIImage(named:"Floor_2.jpg")}
            else if (row == 4){floorMap.image = UIImage(named:"Floor_3.jpg")}
            picker.selectRow(0, inComponent: 0, animated: true)
        }
        else if component == 0{
            //This is if the user selects a department
            if (row == 1 || row == 11 || row == 16 || row == 10)              {floorMap.image = UIImage(named:"Floor_1.jpg")}
            else if (row == 2 || row == 6 || row == 5 || row == 8 || row == 3){floorMap.image = UIImage(named:"Floor_2.jpg")}
            else if (row == 9 || row == 13 || row == 7 || row == 12)          {floorMap.image = UIImage(named:"Floor_3.jpg")}
            else if (row == 4 || row == 17 || row == 15 || row == 14)         {floorMap.image = UIImage(named:"LowerLevels.jpg")}
            picker.selectRow(0, inComponent: 1, animated: true)
        }
        
        
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.floorMap
    }
    
}
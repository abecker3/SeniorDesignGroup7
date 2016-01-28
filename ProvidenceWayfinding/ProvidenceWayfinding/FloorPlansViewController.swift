//
//  FloorPlansViewController.swift
//  ProvidenceWayfinding
//
//  Created by Andrew Becker on 1/26/16.
//  Copyright © 2016 GU. All rights reserved.
//

import UIKit

class FloorPlansViewController: UIViewController {
    
    @IBOutlet weak var textTitle: UITextField!
    @IBOutlet weak var buildingWomens: UIButton!
    @IBOutlet weak var buildingChildrens: UIButton!
    @IBOutlet weak var buildingHeart: UIButton!
    @IBOutlet weak var buildingMain: UIButton!
    @IBOutlet weak var floorL3: UIButton!
    @IBOutlet weak var floorL2: UIButton!
    @IBOutlet weak var floorL1: UIButton!
    @IBOutlet weak var floor1: UIButton!
    @IBOutlet weak var floor2: UIButton!
    @IBOutlet weak var floor3: UIButton!
    @IBOutlet weak var floor4: UIButton!
    @IBOutlet weak var floor5: UIButton!
    @IBOutlet weak var floor6: UIButton!
    @IBOutlet weak var floor7: UIButton!
    
    var building = String()
    var floor = String()
    var underscore = String()
    var fileExtension = String()
    var textBuilding = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        underscore = "_"
        fileExtension = ".jpg"
        initialize()
    }
    
    func initialize(){
        building = "Main"
        floor = "1"
        textBuilding = "Main Tower"
        floorL3.enabled = true
        floorL2.enabled = true
        floorL1.enabled = true
        floor1.enabled = true
        floor2.enabled = true
        floor3.enabled = true
        floor4.enabled = true
        floor5.enabled = true
        floor6.enabled = true
        floor7.enabled = true
        textTitle.text = textBuilding + " Floor " + floor
    }
    

    
    @IBAction func mainPressed(sender: UIButton) {
        building = "Main"
        floor = "1"
        textBuilding = "Main Tower"
        floorL3.enabled = true
        floorL2.enabled = true
        floorL1.enabled = true
        floor1.enabled = true
        floor2.enabled = true
        floor3.enabled = true
        floor4.enabled = true
        floor5.enabled = true
        floor6.enabled = true
        floor7.enabled = true
        textTitle.text = textBuilding + " Floor " + floor
    }
    
    @IBAction func heartPressed(sender: UIButton) {
        building = "Heart"
        floor = "1"
        textBuilding = "Heart Institute"
        floorL3.enabled = false
        floorL2.enabled = false
        floorL1.enabled = false
        floor1.enabled = true
        floor2.enabled = true
        floor3.enabled = true
        floor4.enabled = true
        floor5.enabled = true
        floor6.enabled = false
        floor7.enabled = false
        textTitle.text = textBuilding + " Floor " + floor
    }
    
    @IBAction func childrensPressed(sender: UIButton) {
        building = "Childrens"
        floor = "1"
        textBuilding = "Children's Hospital"
        floorL3.enabled = true
        floorL2.enabled = true
        floorL1.enabled = true
        floor1.enabled = true
        floor2.enabled = true
        floor3.enabled = true
        floor4.enabled = true
        floor5.enabled = false
        floor6.enabled = false
        floor7.enabled = false
        textTitle.text = textBuilding + " Floor " + floor
    }
    
    @IBAction func womensPressed(sender: UIButton) {
        building = "Womens"
        floor = "1"
        textBuilding = "Womens Health Center"
        floorL3.enabled = true
        floorL2.enabled = true
        floorL1.enabled = true
        floor1.enabled = true
        floor2.enabled = true
        floor3.enabled = true
        floor4.enabled = true
        floor5.enabled = false
        floor6.enabled = false
        floor7.enabled = false
        textTitle.text = textBuilding + " Floor " + floor
    }
    
    @IBAction func floorPressed(sender: UIButton) {
        switch sender{
        case floorL3: floor = "L3"
        case floorL2: floor = "L2"
        case floorL1: floor = "L1"
        case floor2: floor = "2"
        case floor3: floor = "3"
        case floor4: floor = "4"
        case floor5: floor = "5"
        case floor6: floor = "6"
        case floor7: floor = "7"
        default: floor = "1"
        }
        textTitle.text = textBuilding + " Floor " + floor
    }
}

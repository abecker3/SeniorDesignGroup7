//
//  FloorPlansViewController.swift
//  ProvidenceWayfinding
//
//  Created by Andrew Becker on 1/26/16.
//  Copyright © 2016 GU. All rights reserved.
//

import UIKit

class FloorPlansViewController: UIViewController {
    @IBOutlet weak var floorMap: UIImageView!
    @IBOutlet weak var scrollMap: UIScrollView!
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
    @IBOutlet weak var floor8: UIButton!
    @IBOutlet weak var floor9: UIButton!
    @IBOutlet weak var floor10: UIButton!
    
    var building = String()
    var floor = String()
    var underscore = String()
    var fileExtension = String()
    var textBuilding = String()
    var imageName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        underscore = "_"
        fileExtension = ".jpg"
        initialize()
        
        self.scrollMap.maximumZoomScale = 5.0
        self.scrollMap.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: "doubleTapped")
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.floorMap
    }
    
    func setButtons(a: Bool,b: Bool,c: Bool,d: Bool,e: Bool,f: Bool,g: Bool,h: Bool,i: Bool,j: Bool, k: Bool, l: Bool, m: Bool){
        floorL3.enabled = a
        floorL2.enabled = b
        floorL1.enabled = c
        floor1.enabled = d
        floor2.enabled = e
        floor3.enabled = f
        floor4.enabled = g
        floor5.enabled = h
        floor6.enabled = i
        floor7.enabled = j
        floor8.enabled = k
        floor9.enabled = l
        floor10.enabled = m
    }
    
    func initialize(){
        building = "Main"
        floor = "1"
        textBuilding = "Main Tower"
        setButtons(true, b: true, c: true, d: true, e: true, f: true, g: true, h: true, i: true, j: true, k: true, l: true, m: true)
        textTitle.text = textBuilding + " Floor " + floor
        imageName = building + underscore + floor + fileExtension
        floorMap.image = UIImage(named: imageName)
        floorMap.contentMode = UIViewContentMode.ScaleAspectFit
    }
    

    
    @IBAction func mainPressed(sender: UIButton) {
        building = "Main"
        floor = "1"
        textBuilding = "Main Tower"
        setButtons(true, b: true, c: true, d: true, e: true, f: true, g: true, h: true, i: true, j: true, k: true, l: true, m: true)
        textTitle.text = textBuilding + " Floor " + floor
        imageName = building + underscore + floor + fileExtension
        floorMap.image = UIImage(named: imageName)
        floorMap.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
    @IBAction func heartPressed(sender: UIButton) {
        building = "Heart"
        floor = "1"
        textBuilding = "Heart Institute"
        setButtons(false, b: false, c: false, d: true, e: true, f: true, g: true, h: true, i: false, j: false, k: false, l: false, m: false)
        textTitle.text = textBuilding + " Floor " + floor
        imageName = building + underscore + floor + fileExtension
        floorMap.image = UIImage(named: imageName)
        floorMap.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
    @IBAction func childrensPressed(sender: UIButton) {
        building = "Childrens"
        floor = "1"
        textBuilding = "Children's Hospital"
        setButtons(true, b: true, c: true, d: true, e: true, f: true, g: true, h: false, i: false, j: false, k: false, l: false, m: false)
        textTitle.text = textBuilding + " Floor " + floor
        imageName = building + underscore + floor + fileExtension
        floorMap.image = UIImage(named: imageName)
        floorMap.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
    @IBAction func womensPressed(sender: UIButton) {
        building = "Womens"
        floor = "1"
        textBuilding = "Womens Health Center"
        setButtons(true, b: true, c: true, d: true, e: true, f: true, g: false, h: false, i: false, j: false, k: false, l: false, m: false)
        textTitle.text = textBuilding + " Floor " + floor
        imageName = building + underscore + floor + fileExtension
        floorMap.image = UIImage(named: imageName)
        floorMap.contentMode = UIViewContentMode.ScaleAspectFit
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
        case floor8: floor = "8"
        case floor9: floor = "9"
        case floor10: floor = "10"
        default: floor = "1"
        }
        textTitle.text = textBuilding + " Floor " + floor
        imageName = building + underscore + floor + fileExtension
        floorMap.image = UIImage(named: imageName)
        floorMap.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
    func doubleTapped() {
        if (scrollMap.zoomScale > 1){
            scrollMap.setZoomScale(0.25, animated: true)
        }
        else{
            scrollMap.setZoomScale(2, animated: true)
        }
    }
}

//
//  DestinationViewController.swift
//  ProvidenceWayfinding
//
//  Created by Andrew Becker on 1/25/16.
//  Copyright © 2016 GU. All rights reserved.
//


import UIKit

class DestinationViewController: UIViewController, UIScrollViewDelegate{
    @IBOutlet weak var whichFloor: UITextField!
    @IBOutlet weak var floorMap: UIImageView!
    @IBOutlet weak var scrollMap: UIScrollView!
    
    var destinationFloor = String()
    var endBuilding = String()
    var textDestinationFloor = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        floorMap.image = UIImage(named: destinationFloor)
        floorMap.contentMode = UIViewContentMode.ScaleAspectFit
        
        self.scrollMap.maximumZoomScale = 5.0
        self.scrollMap.clipsToBounds = true
        
        whichFloor.text = endBuilding + " Floor " + textDestinationFloor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
            return self.floorMap
    }
    
}
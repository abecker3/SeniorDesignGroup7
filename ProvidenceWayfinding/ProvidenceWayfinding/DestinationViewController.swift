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
        
        let tap = UITapGestureRecognizer(target: self, action: "doubleTapped")
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        
        floorMap.image = UIImage(named: destinationFloor)
        floorMap.contentMode = UIViewContentMode.ScaleAspectFit
        floorMap.frame = CGRect(origin: CGPoint(x: 0, y: 0), size:((floorMap.image)?.size)!)
        
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
    
    func doubleTapped() {
        if (scrollMap.zoomScale > 1){
            scrollMap.setZoomScale(0.25, animated: true)
        }
        else{
            scrollMap.setZoomScale(2, animated: true)
        }
    }
    
}
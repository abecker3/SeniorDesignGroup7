//
//  CampusViewController.swift
//  ProvidenceWayfinding
//
//  Created by Becker, Andrew D on 11/22/15.
//  Copyright © 2015 GU. All rights reserved.
//


import UIKit

class CampusViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var campusScroll: UIScrollView!
    @IBOutlet weak var campusMap: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: "doubleTapped")
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        
        campusMap.image = UIImage(named:"Campus.jpg")
        campusMap.contentMode = UIViewContentMode.ScaleToFill
        self.campusMap.clipsToBounds = true
        
        self.campusScroll.maximumZoomScale = 5.0
        self.campusScroll.minimumZoomScale = 2.0
        self.campusScroll.clipsToBounds = true
        
        campusScroll.setZoomScale(2, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.campusMap
    }
    
    func doubleTapped() {
        if (campusScroll.zoomScale > 2){
            campusScroll.setZoomScale(2, animated: true)
        }
        else{
            campusScroll.setZoomScale(4, animated: true)
        }
    }
}

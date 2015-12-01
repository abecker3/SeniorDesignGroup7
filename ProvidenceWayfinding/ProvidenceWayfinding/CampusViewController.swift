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
        
        campusMap.image = UIImage(named:"Campus.jpg")
        campusMap.contentMode = UIViewContentMode.ScaleAspectFit
        self.campusMap.clipsToBounds = true
        
        self.campusScroll.maximumZoomScale = 5.0
        self.campusScroll.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.campusMap
    }
    
}

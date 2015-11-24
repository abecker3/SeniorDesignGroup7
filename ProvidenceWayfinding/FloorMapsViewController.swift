//
//  FloorMapsViewController.swift
//  ProvidenceWayfinding
//
//  Created by Bilsborough, Michael J on 11/11/15.
//  Copyright © 2015 GU. All rights reserved.
//

import UIKit

class FloorMapsViewController: UIViewController {
    
    //Variables
    
    //Outlets
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var floorLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    //Actions
    @IBAction func segmentedControl(sender: AnyObject) {
        buildingLabel.text = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)!;
        updateImage();
    }
  
    
    
    @IBAction func L1(sender: AnyObject) {
        floorLabel.text = "L1";
        updateImage();
    }
    
    @IBAction func L2(sender: AnyObject) {
        floorLabel.text = "L2";
        updateImage();
    }
    
    @IBAction func L3(sender: AnyObject) {
        floorLabel.text = "L3";
        updateImage();
    }
    
    func updateImage(){
        imageView.image = UIImage(named: "providence_logo");
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

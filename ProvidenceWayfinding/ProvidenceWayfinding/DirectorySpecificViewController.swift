//
//  DirectorySpecificViewController.swift
//  ProvidenceWayfinding
//
//  Created by Ruth Manthey on 1/26/16.
//  Copyright © 2016 GU. All rights reserved.
//

import UIKit

class DirectorySpecificViewController: UIViewController {

    var passInName: String!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var floorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = passInName
        
        //phoneLabel.text =
    }
    
}

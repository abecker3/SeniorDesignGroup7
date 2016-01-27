//
//  DirectorySpecificViewController.swift
//  ProvidenceWayfinding
//
//  Created by Ruth Manthey on 1/26/16.
//  Copyright © 2016 GU. All rights reserved.
//

import UIKit

class DirectorySpecificViewController: UIViewController {

    var passInCategory: String!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = passInCategory
        //phoneLabel.text =
    }
    
}

//
//  ContentViewController.swift
//  ProvidenceWayfinding
//
//  Created by Derek Becker on 3/15/16.
//  Copyright © 2016 GU. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var pageIndex: Int!
    var titleText: String!
    var imageFile: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = UIImage(named: self.imageFile)
        self.titleLabel.text = self.titleText
        
        setTextField()
    }
    
    func setTextField(){
        if (titleText == "Home"){
            textField.text = "Home Instructions"
        }
        else if (titleText == "Directions"){
            textField.text = "Directions Instructions"
        }
        else if (titleText == "Parking"){
            textField.text = "Parking Instructions"
        }
        else if (titleText == "More"){
            textField.text = "More Instructions"
        }
    }
    
    
    
}
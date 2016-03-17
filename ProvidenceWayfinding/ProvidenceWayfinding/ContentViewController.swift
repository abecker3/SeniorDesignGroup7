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
            textField.text = "From the Home tab you can: \n\n1) View the tutorial to learn the functionality of the app \n\n2) Read the mission of Providence Sacred Heart"
        }
        else if (titleText == "Directions"){
            textField.text = "From the Directions tab you can: \n\n1) View general tips about navigating the Hospital by clicking the 'Completely Lost?' button \n\n2) View all available floor maps by clicking the 'Floor Maps' button \n\n3) To get directions click the 'Route Now' button \n\tA) If your current location was 'Off Campus' the app will: \n\t\ta) Guide you to the best parking garage for your destination \n\t\t\ti) To view the written directions you can click the button on the right that resembles four lines \n\t\t\tii) There is an option at the bottom to use Apple Maps so that you can have voice navigation to the parking garage entrance \n\t\tb) The app will then prompt you to save your parking location \n\tB) The app will then begin navigating you through the hospital to your destination"
        }
        else if (titleText == "Parking"){
            textField.text = "From the Parking tab you can: \n\n1) Save your parking location \n\n2) View your most recent saved parking location \n\n3) Click on the History button to view the last 10 saved parking locations"
        }
        else if (titleText == "More"){
            textField.text = "From the More tab you can: \n\n1) View the directory which allows you to search and view all locations that are supported in the app to learn: \n\tA) The phone extension \n\tB) The hours \n\tC) What building and floor the location is on \n\n2) View a map of the entire campus \n\n3) Read the terms of service"
        }
        
        textField.font = UIFont(name: "Helvetica", size: 16)
    }
    
}
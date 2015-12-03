//
//  HoursViewController.swift
//  ProvidenceWayfinding
//
//  Created by Shaun McBurney on 11/30/15.
//  Copyright © 2015 GU. All rights reserved.
//

import UIKit

class HoursViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var servicesView: UIView!
    @IBOutlet weak var concessionsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showComponent(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UIView.animateWithDuration(0.5, animations: {
                self.servicesView.alpha = 1
                self.concessionsView.alpha = 0
            })
        } else {
            UIView.animateWithDuration(0.5, animations: {
                self.servicesView.alpha = 0
                self.concessionsView.alpha = 1
            })
        }
    }


    
}

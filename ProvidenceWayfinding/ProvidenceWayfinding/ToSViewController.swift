//
//  ToSViewController.swift
//  ProvidenceWayfinding
//
//  Created by Becker, Andrew D on 11/10/15.
//  Copyright © 2015 GU. All rights reserved.
//

import UIKit

class ToSViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.textView.scrollRangeToVisible(NSMakeRange(0, 0))
        prepParking()
    }
    
}
//
//  ToSMoreViewController.swift
//  ProvidenceWayfinding
//
//  Created by Becker, Andrew D on 11/10/15.
//  Copyright © 2015 GU. All rights reserved.
//

import UIKit

class ToSMoreViewController: UIViewController {
    @IBOutlet weak var textView2: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.textView2.scrollRangeToVisible(NSMakeRange(0, 0))
    }
    
}
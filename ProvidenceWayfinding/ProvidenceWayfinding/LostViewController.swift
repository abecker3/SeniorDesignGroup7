//
//  LostViewController.swift
//  ProvidenceWayfinding
//
//  Created by Becker, Andrew D on 12/6/15.
//  Copyright © 2015 GU. All rights reserved.
//

import UIKit

class LostViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.textView.scrollRangeToVisible(NSMakeRange(0, 0))
    }
    
}

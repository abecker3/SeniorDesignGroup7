//
//  MoreViewController.swift
//  ProvidenceWayfinding
//
//  Created by Shaun McBurney on 12/1/15.
//  Copyright © 2015 GU. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    
    var screenEdgeRecognizer: UIScreenEdgePanGestureRecognizer!
    var flag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "switchScreenGesture:")
        screenEdgeRecognizer.edges = .Left
        view.addGestureRecognizer(screenEdgeRecognizer)
    }
    
    func switchScreenGesture(sender: UIScreenEdgePanGestureRecognizer) {
        flag = flag + 1
        if (flag % 2 == 1){
            tabBarController?.selectedIndex = 2
        }
    }
    
    
}

//
//  HomeViewController.swift
//  ProvidenceWayfinding
//
//  Created by Becker, Andrew D on 11/24/15.
//  Copyright © 2015 GU. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var screenEdgeRecognizer: UIScreenEdgePanGestureRecognizer!
    var flag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "switchScreenGesture:")
        screenEdgeRecognizer.edges = .Right
        view.addGestureRecognizer(screenEdgeRecognizer)
    }
    
    func switchScreenGesture(sender: UIScreenEdgePanGestureRecognizer) {
        flag = flag + 1
        if (flag % 2 == 1){
            tabBarController?.selectedIndex = 1
        }
    }

}

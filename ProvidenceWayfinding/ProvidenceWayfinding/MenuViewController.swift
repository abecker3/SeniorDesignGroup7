//
//  MenuViewController.swift
//  MapTest
//
//  Created by Taras Kravchuk on 10/27/15.
//  Copyright © 2015 Taras Kravchuk. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    let transitionManager = TransitionManager()

    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var DirectHospital: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
        //scrollView.contentSize = CGSizeMake(320, 520)
        //scrollView.alwaysBounceVertical = true
        //scrollView.showsVerticalScrollIndicator = true
        //scrollView.decelerationRate = 0.99
        
        //scrollView.backgroundColor = UIColor.blackColor()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // this gets a reference to the screen that we're about to transition to
        let toViewController = segue.destinationViewController as UIViewController
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        toViewController.transitioningDelegate = self.transitionManager
        
    }
    
    @IBAction func unwindToViewController (sender: UIStoryboardSegue){
        
    }
    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }*/


}

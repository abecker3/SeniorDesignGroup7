//
//  MoreViewController.swift
//  ProvidenceWayfinding
//
//  Created by Shaun McBurney on 12/1/15.
//  Copyright © 2015 GU. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var screenEdgeRecognizer: UIScreenEdgePanGestureRecognizer!
    var flag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "switchScreenGesture:")
        screenEdgeRecognizer.edges = .Left
        view.addGestureRecognizer(screenEdgeRecognizer)
        
        let scrollViewWidth = scrollView.frame.width
        let scrollViewHeight = scrollView.frame.height
        //print("scrollViewWidth = " + String(scrollViewWidth))
        //print("scrollViewHeight = " + String(scrollViewHeight))
        
        //3
        let imgThree = UIImageView(frame: CGRectMake(scrollViewWidth*0, 0, scrollViewWidth, scrollViewHeight))
        imgThree.image = UIImage(named: "Map.png")
        let imgFour = UIImageView(frame: CGRectMake(scrollViewWidth*1, 0,scrollViewWidth, scrollViewHeight))
        imgFour.image = UIImage(named: "Car.png")
        print("imgFour.image.size = " + String(imgFour.image!.size))
        /*
        //4
        self.scrollView.addSubview(imgThree)
        self.scrollView.addSubview(imgFour)
        //4
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * 2, self.scrollView.frame.height)
        self.scrollView.delegate = self
        //self.pageControl.currentPage = 0
        
        
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "moveToNextPage", userInfo: nil, repeats: true)
 
        */
    }
    
    func switchScreenGesture(sender: UIScreenEdgePanGestureRecognizer) {
        flag = flag + 1
        if (flag % 2 == 1){
            tabBarController?.selectedIndex = 2
        }
    }
    
    
}

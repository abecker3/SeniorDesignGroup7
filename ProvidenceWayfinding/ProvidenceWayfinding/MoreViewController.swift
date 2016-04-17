//
//  MoreViewController.swift
//  ProvidenceWayfinding
//
//  Created by Shaun McBurney on 12/1/15.
//  Copyright © 2015 GU. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var screenEdgeRecognizer: UIScreenEdgePanGestureRecognizer!
    var imageViewHeight: CGFloat = 0
    var flag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentOffset = CGPointZero
        
        screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "switchScreenGesture:")
        screenEdgeRecognizer.edges = .Left
        view.addGestureRecognizer(screenEdgeRecognizer)
        
        scrollView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height * 0.6)
        let scrollViewWidth = scrollView.frame.width
        let scrollViewHeight = scrollView.frame.height
        //print("scrollViewWidth = " + String(scrollViewWidth))
        //print("scrollViewHeight = " + String(scrollViewHeight))
        
        //3
        let imgThree = UIImageView(frame: CGRectMake(scrollViewWidth*0, 0, scrollViewWidth, scrollViewHeight))
        imgThree.contentMode = .ScaleAspectFit
        imageViewHeight = imgThree.frame.height
        imgThree.image = UIImage(named: "providence_logo1.png")
        let imgFour = UIImageView(frame: CGRectMake(scrollViewWidth*1, 0,scrollViewWidth, scrollViewHeight))
        imgThree.contentMode = .ScaleAspectFit

        imgFour.image = UIImage(named: "childrensHospitalAtNight.jpg")
        //print("imgFour.image.size = " + String(imgFour.image!.size))
        
        //4
        self.scrollView.addSubview(imgThree)
        self.scrollView.addSubview(imgFour)
        //4
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * 2, self.scrollView.frame.height)
        self.scrollView.delegate = self
        //self.pageControl.currentPage = 0
        
        
        NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: "moveToNextPage", userInfo: nil, repeats: true)
 
        
    }
    
    func switchScreenGesture(sender: UIScreenEdgePanGestureRecognizer) {
        flag = flag + 1
        if (flag % 2 == 1){
            tabBarController?.selectedIndex = 2
        }
    }
    
    func moveToNextPage (){
        print(CGRectGetWidth(scrollView.frame))
        print(CGRectGetHeight(scrollView.frame))
        
        scrollView.setContentOffset(CGPoint(x: 600, y: 0), animated: true)
        let pageWidth:CGFloat = CGRectGetWidth(self.scrollView.frame)
        let maxWidth:CGFloat = pageWidth * 2
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        print("ScrollView height = " + String(scrollView.frame.height))
        print("ImageView3 height = " + String(imageViewHeight))
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth{
            slideToX = 0
        }
        self.scrollView.scrollRectToVisible(CGRectMake(slideToX, 0, pageWidth, CGRectGetHeight(self.scrollView.frame)), animated: true)
    }
    
    
}

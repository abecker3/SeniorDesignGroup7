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
    @IBOutlet weak var scrollViewFrameHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollViewWidthConstraint: NSLayoutConstraint!
    var imageViewHeight: CGFloat = 0
    var imageViewWidth: CGFloat = 0
    var image2ViewHeight: CGFloat = 0
    var image2ViewWidth: CGFloat = 0
    var flag = 0
    var loopFlag: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.setNeedsLayout()
        
        //scrollView.contentOffset = CGPointZero
        
        screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "switchScreenGesture:")
        screenEdgeRecognizer.edges = .Left
        view.addGestureRecognizer(screenEdgeRecognizer)
        
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "moveToNextPage", userInfo: nil, repeats: true)
    }
    
    /*
    @post:  The loopFlag is set to false, which causes an if statement that pages the ImageViews
    Description: When the view dissapears the paging back and forth stops. This is due to loopFlag
                 being set false, which means the looping paging effect will not happen.
    */
    override func viewDidDisappear(animated: Bool) {
        loopFlag = false
        //scrollView.contentOffset = CGPointZero
    }
    
    /*
    Description: Sets the paging effect to true, meaning the images will scroll. Continues to create the ImageViews within
     the scrollView and set the contentSize of the scrollView.
    */
    override func viewDidAppear(animated: Bool) {
        //loopFlag is set to true since the user is now looking at the pictures, making the paging effect loop every
        // three seconds
        loopFlag = true
        
        let scrollViewWidth = CGRectGetWidth(scrollView.frame)
        let scrollViewHeight = CGRectGetHeight(scrollView.frame)
        
        //let scrollViewWidth = scrollViewWidthConstraint.constant
        //let scrollViewHeight = scrollViewFrameHeight.constant
        
        
        //print("scrollView.frame.height = " + String(scrollView.frame.height))
        //print("scrollViewHeight = " + String(scrollViewHeight))
        //print("Height from constraint outlet = " + String(scrollViewFrameHeight.firstAttribute))
        
    
        //CGRectMake makes a frame for the ImageView. CGRectMake's first param is the frames x coordinate in
        // relation to its superview, which is the scrollView
        let imgThree = UIImageView(frame: CGRectMake(scrollViewWidth*0, 0, scrollViewWidth, scrollViewHeight))
        //imageViewHeight = imgThree.frame.height
        //imageViewWidth = imgThree.frame.width
        imgThree.image = UIImage(named: "Emergency")
        imgThree.contentMode = .ScaleAspectFill // make's the image fit into the ImageView

        let imgFour = UIImageView(frame: CGRectMake(scrollViewWidth*2, 0,scrollViewWidth, scrollViewHeight))
        image2ViewHeight = imgFour.frame.height
        image2ViewWidth = imgFour.frame.width
        imgFour.contentMode = .ScaleAspectFit
        imgFour.image = UIImage(named: "providence_logo1.png")
        //print("imgFour.image.size = " + String(imgFour.image!.size))
        
        let imgFive = UIImageView(frame: CGRectMake(scrollViewWidth*1, 0, scrollViewWidth, scrollViewHeight))
        imgFive.image = UIImage(named: "Childrens")
        //imgFive.contentMode = .ScaleAspectFit
        
        //4
        self.scrollView.addSubview(imgThree)
        
        self.scrollView.addSubview(imgFive)
        self.scrollView.addSubview(imgFour)
        //let constraint = NSLayoutConstraint(item: imgThree, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: scrollView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 1).active = true
        //let constraint2 = NSLayoutConstraint(item: imgThree, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 1).active = true
       // let constraint3 = NSLayoutConstraint(item: imgThree, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: scrollView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 1).active = true
        //scrollView.addConstraint(constraint)
        //self.view.addConstraint(constraint2)
       // scrollView.addConstraint(constraint3)
        //4
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * 3, self.scrollView.frame.height)
        //self.scrollView.contentSize = CGSizeMake(scrollViewWidthConstraint.constant * 2, scrollViewHeight)
        self.scrollView.delegate = self
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
        
        //print("scrollView.frame.height at beginning of switch = " + String(scrollView.frame.height))
        print("scrollViewHeight at beginning of switch = " + String(CGRectGetHeight(scrollView.frame)))
        
        //scrollView.setContentOffset(CGPoint(x: 600, y: 0), animated: true)
        let pageWidth:CGFloat = CGRectGetWidth(self.scrollView.frame)
        //let pageHeight:CGFloat = CGRectGetHeight(self.scrollView.frame)
        //print("The complete scrollView frame = " + String(scrollView.frame))
        //let pageWidth:CGFloat = scrollViewWidthConstraint.constant

        let maxWidth:CGFloat = pageWidth * 3
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        //print("ScrollView height = " + String(scrollView.frame.height))
        print("ImageView3 height = " + String(imageViewHeight))
        print("ImageView3 width = " + String(imageViewWidth))
        print("ImageView4 height = " + String(image2ViewHeight))
        print("ImageView4 width = " + String(image2ViewWidth))
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth >= maxWidth{
            slideToX = 0
        }
        
        if(loopFlag == true) {
        self.scrollView.scrollRectToVisible(CGRectMake(slideToX, 0, pageWidth, CGRectGetHeight(scrollView.frame)), animated: true)
        }
    }
    
    
}

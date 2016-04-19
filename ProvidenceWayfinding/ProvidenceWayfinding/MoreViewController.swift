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
        
        
        /*
        //scrollView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        scrollView.frame = CGRectMake(0, 0, scrollViewWidthConstraint.constant, scrollViewFrameHeight.constant)

        //let scrollViewWidth = scrollView.frame.width
        //let scrollViewHeight = scrollView.frame.height
        
        let scrollViewWidth = CGRectGetWidth(scrollView.frame)
        let scrollViewHeight = CGRectGetHeight(scrollView.frame)
        
        //let scrollViewWidth = scrollViewWidthConstraint.constant
        //let scrollViewHeight = scrollViewFrameHeight.constant
        
        
        print("scrollView.frame.height = " + String(scrollView.frame.height))
        print("scrollViewHeight = " + String(scrollViewHeight))
        //print("Height from constraint outlet = " + String(scrollViewFrameHeight.firstAttribute))
        
        
        //3
        //let imgThree = UIImageView(frame: CGRectMake(scrollViewWidth*0, 0, scrollViewWidth, scrollViewHeight))
        let imgThree = UIImageView(frame: CGRectMake(scrollViewWidth*0, 0, scrollViewWidthConstraint.constant, scrollViewHeight))
        imgThree.contentMode = .ScaleAspectFit
        imageViewHeight = imgThree.frame.height
        imageViewHeight = imgThree.frame.width
        imgThree.image = UIImage(named: "providence_logo1.png")
        let imgFour = UIImageView(frame: CGRectMake(scrollViewWidth*1, 0,scrollViewWidth, scrollViewHeight))
        imgThree.contentMode = .ScaleAspectFit

        imgFour.image = UIImage(named: "HomeTab")
        //print("imgFour.image.size = " + String(imgFour.image!.size))
        
        //4
        self.scrollView.addSubview(imgThree)
        self.scrollView.addSubview(imgFour)
        /*let constraint = NSLayoutConstraint(item: imgThree, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: scrollView, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 1)
        scrollView.addConstraint(constraint)*/
        //4
        //self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * 2, self.scrollView.frame.height)
        self.scrollView.contentSize = CGSizeMake(scrollViewWidthConstraint.constant * 2, scrollViewHeight)
        self.scrollView.delegate = self
        //self.pageControl.currentPage = 0
        
        
        //NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: "moveToNextPage", userInfo: nil, repeats: loopFlag)
 
        print("scrollView.frame.height at end of viewDidLoad = " + String(scrollView.frame.height))
        print("scrollViewHeight in switching pics at end of viewDidLoad = " + String(scrollViewHeight))*/
    }
    
    override func viewDidDisappear(animated: Bool) {
        loopFlag = false
        //scrollView.contentOffset = CGPointZero
    }
    
    override func viewDidAppear(animated: Bool) {
        loopFlag = true
        NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: "moveToNextPage", userInfo: nil, repeats: loopFlag)
        //scrollView.contentOffset = CGPointZero
        print("ViewDidAppear's scrollView frame = " + String(scrollView.frame))
        //print(scrollView.frame)

        //scrollView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height * 0.6)
        //print("ViewDidAppear's scrollView frame = " + String(scrollView.frame))

        //scrollView.frame = CGRectMake(0, 0, scrollViewWidthConstraint.constant, scrollViewFrameHeight.constant)
        
        //let scrollViewWidth = scrollView.frame.width
        //let scrollViewHeight = scrollView.frame.height
        
        let scrollViewWidth = CGRectGetWidth(scrollView.frame)
        let scrollViewHeight = CGRectGetHeight(scrollView.frame)
        
        //let scrollViewWidth = scrollViewWidthConstraint.constant
        //let scrollViewHeight = scrollViewFrameHeight.constant
        
        
        //print("scrollView.frame.height = " + String(scrollView.frame.height))
        //print("scrollViewHeight = " + String(scrollViewHeight))
        //print("Height from constraint outlet = " + String(scrollViewFrameHeight.firstAttribute))
        
        
        //3
        let imgThree = UIImageView(frame: CGRectMake(scrollViewWidth*0, 0, scrollViewWidth, scrollViewHeight))
        imgThree.contentMode = .ScaleAspectFit
        imageViewHeight = imgThree.frame.height
        imageViewWidth = imgThree.frame.width
        imgThree.image = UIImage(named: "providence_logo1.png")
        let imgFour = UIImageView(frame: CGRectMake(scrollViewWidth*1, 0,scrollViewWidth, scrollViewHeight))
        image2ViewHeight = imgFour.frame.height
        image2ViewWidth = imgFour.frame.width

        imgThree.contentMode = .ScaleAspectFit
        
        imgFour.image = UIImage(named: "ChildrensPicture")
        //print("imgFour.image.size = " + String(imgFour.image!.size))
        
        //4
        self.scrollView.addSubview(imgThree)
        self.scrollView.addSubview(imgFour)
        //let constraint = NSLayoutConstraint(item: imgThree, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: scrollView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 1).active = true
        //let constraint2 = NSLayoutConstraint(item: imgThree, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 1).active = true
       // let constraint3 = NSLayoutConstraint(item: imgThree, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: scrollView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 1).active = true
        //scrollView.addConstraint(constraint)
        //self.view.addConstraint(constraint2)
       // scrollView.addConstraint(constraint3)
        //4
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * 2, self.scrollView.frame.height)
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

        let maxWidth:CGFloat = pageWidth * 2
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
        self.scrollView.scrollRectToVisible(CGRectMake(slideToX, 0, pageWidth, CGRectGetHeight(scrollView.frame)), animated: true)
    }
    
    
}

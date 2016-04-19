//
//  pathView.swift
//  wayfinding test
//
//  Created by Bilsborough, Michael J on 2/14/16.
//  Copyright © 2016 Gonzaga University. All rights reserved.
//

import UIKit

class pathView: UIView {
    
    var path: [Vertex]?;

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, path: [Vertex]) {
        super.init(frame: frame);
        self.path = path;
        backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func drawRect(rect: CGRect)
    {
        let route = UIBezierPath()
        route.lineWidth = 10.0
        UIColor.blueColor().setStroke()
        
        let startX = CGFloat(path![0].x)
        let startY = CGFloat(path![0].y)
        route.moveToPoint(CGPoint(x: startX, y: startY))
        
        for v in path!
        {
            if(v.previous != nil)
            {
                let x = CGFloat(v.x)
                let y = CGFloat(v.y)
                route.addLineToPoint(CGPoint(x: x, y: y))
            }
        }
        route.stroke();
    }
}

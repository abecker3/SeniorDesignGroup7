//
//  pathView.swift
//  wayfinding test
//
//  Created by Bilsborough, Michael J on 2/14/16.
//  Copyright © 2016 Gonzaga University. All rights reserved.
//

import UIKit

class lineView: UIView {
    
    var directions = [Direction]()
    var currentDirectionsIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, directions: [Direction], currentDirectionsIndex: Int) {
        super.init(frame: frame);
        self.directions = directions;
        self.currentDirectionsIndex = currentDirectionsIndex
        backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func drawRect(rect: CGRect)
    {
        
        var directionsIndex = 0
        let currentBuilding = directions[currentDirectionsIndex].vertices[0].building
        let currentFloor = directions[currentDirectionsIndex].vertices[0].floor
        for d in directions
        {
            if(d.vertices[0].building != currentBuilding || d.vertices[0].floor != currentFloor)
            {
                directionsIndex += 1
                continue;
            }
            
            let route = UIBezierPath()
            let startX = CGFloat(d.vertices[0].x)
            let startY = CGFloat(d.vertices[0].y)
            route.moveToPoint(CGPoint(x: startX, y: startY))
            
            if (directionsIndex < currentDirectionsIndex)
            {
                UIColor.blueColor().colorWithAlphaComponent(0.2).setStroke()
                route.lineWidth = 15.0
                //let dashes :[CGFloat] = [0, 0]
                //route.setLineDash(dashes, count: 2, phase: 0)
            }
            else if(directionsIndex == currentDirectionsIndex)
            {
                UIColor.blueColor().colorWithAlphaComponent(0.8).setStroke()
                route.lineWidth = 15.0
                //let dashes :[CGFloat] = []
                //route.setLineDash(dashes, count: 0, phase: 0)
            }
            else
            {
                UIColor.blueColor().colorWithAlphaComponent(0.2).setStroke()
                route.lineWidth = 15.0
                //let dashes :[CGFloat] = [0, 0]
                //route.setLineDash(dashes, count: 2, phase: 0)
            }
            
            for v in d.vertices
            {
                let x = CGFloat(v.x)
                let y = CGFloat(v.y)
                route.addLineToPoint(CGPoint(x: x, y: y))
            }
            
            route.stroke();
            directionsIndex += 1
        }
    }
}

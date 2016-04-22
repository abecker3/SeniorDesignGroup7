//
//  pathView.swift
//  wayfinding test
//
//  Created by Bilsborough, Michael J on 2/14/16.
//  Copyright © 2016 Gonzaga University. All rights reserved.
//

import UIKit

class lineView: UIView
{
    
    var directions = [Direction]()
    var currentDirectionsIndex = 0
    var currentBuilding: String = ""
    var currentFloor: String = ""
    
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
        currentBuilding = directions[currentDirectionsIndex].vertices[0].building
        currentFloor = directions[currentDirectionsIndex].vertices[0].floor
        
        var pastDirections = [Direction]()
        var currentDirections = [Direction]()
        var futureDirections = [Direction]()
        
        var directionsIndex = 0
        for d in directions
        {
            if (directionsIndex < currentDirectionsIndex)
            {
                pastDirections.append(d)
            }
            else if (directionsIndex == currentDirectionsIndex)
            {
                currentDirections.append(d)
            }
            else
            {
                futureDirections.append(d)
            }
            directionsIndex += 1
        }
        
        if(pastDirections.count > 0)
        {
            drawRouteSection(pastDirections, alpha: 0.2, lineWidth: 10.0)
        }
        if(currentDirections.count > 0)
        {
            drawRouteSection(currentDirections, alpha: 0.8, lineWidth: 10.0)
        }
        if(futureDirections.count > 0)
        {
            drawRouteSection(futureDirections, alpha: 0.2, lineWidth: 10.0)
        }
    }
    
    func drawRouteSection(section: [Direction], alpha: CGFloat, lineWidth: CGFloat)
    {
        let route = UIBezierPath()
        var startX : CGFloat
        var startY : CGFloat
        
        for d in section
        {
            if(d.vertices[0].building == currentBuilding && d.vertices[0].floor == currentFloor)
            {
                startX = CGFloat(d.vertices[0].x)
                startY = CGFloat(d.vertices[0].y)
                route.moveToPoint(CGPoint(x: startX, y: startY))
                break
            }
        }
        
        for d in section
        {
            if(d.vertices[0].building != currentBuilding || d.vertices[0].floor != currentFloor)
            {
                continue;
            }
            
            UIColor.blueColor().colorWithAlphaComponent(alpha).setStroke()
            route.lineWidth = lineWidth
            
            for v in d.vertices
            {
                let x = CGFloat(v.x)
                let y = CGFloat(v.y)
                route.addLineToPoint(CGPoint(x: x, y: y))
            }
        }
        route.stroke()
    }
}

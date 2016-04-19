//
//  Edge.swift
//  wayfinding test
//
//  Created by Bilsborough, Michael J on 2/11/16.
//  Copyright © 2016 Gonzaga University. All rights reserved.
//

import Foundation

class Edge
{
    var vertexA: Vertex;
    var vertexB: Vertex;
    var distance: Float?;
    
    init(initVertexA: Vertex, initVertexB: Vertex)
    {
        vertexA = initVertexA;
        vertexB = initVertexB;
        distance = calcDistance(initVertexA, end: initVertexB);
    }
    
    func calcDistance(start: Vertex, end: Vertex) -> Float
    {
        var d: Float;
        
        if(vertexA.floor == vertexB.floor && vertexA.building == vertexB.building)
        {
            d = sqrt((end.x - start.x) * (end.x - start.x) + (end.y - start.y) * (end.y - start.y));
        }
        else
        {
            d = 10000;
        }
        
        return d;
    }
}
//
//  Vertex.swift
//  wayfinding test
//
//  Created by Bilsborough, Michael J on 2/11/16.
//  Copyright © 2016 Gonzaga University. All rights reserved.
//

import Foundation

class Vertex
{
    var id: Int;
    var name: String;
    var x: Float;
    var y: Float;
    var building: String;
    var floor: String;
    var pathDistance: Float?;
    var visited: Bool?;
    var connections: [Connection];
    var previous: Vertex?;
    
    init(initId: Int, initName: String, initX: Float, initY: Float, initBuilding: String, initFloor: String)
    {
        id = initId;
        name = initName;
        x = initX;
        y = initY;
        building = initBuilding;
        floor = initFloor;
        connections = [];
        previous = nil;
    }
}
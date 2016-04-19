//
//  Connection.swift
//  wayfinding test
//
//  Created by Bilsborough, Michael J on 2/11/16.
//  Copyright © 2016 Gonzaga University. All rights reserved.
//

import Foundation

class Connection
{
    var vertex: Vertex;
    var distance: Float;
    
    init(initVertex: Vertex, initDistance: Float)
    {
        vertex = initVertex;
        distance = initDistance;
    }
}
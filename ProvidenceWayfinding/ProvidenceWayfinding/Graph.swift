//
//  Graph.swift
//  wayfinding test
//
//  Created by Bilsborough, Michael J on 2/11/16.
//  Copyright © 2016 Gonzaga University. All rights reserved.
//

import Foundation

class Graph
{
    var vertices: [Vertex];
    var edges: [Edge];
    
    init()
    {
        vertices = [];
        edges = [];
    }
    
    func addVertex(newVertex: Vertex)
    {
        vertices.append(newVertex);
    }
    
    func addEdge(newEdge: Edge)
    {
        edges.append(newEdge);
    
        for v in vertices
        {
            if (v.id == newEdge.vertexA.id)
            {
                v.connections.append(Connection(initVertex: newEdge.vertexB, initDistance: newEdge.distance!));
            }
            else if (v.id == newEdge.vertexB.id)
            {
                v.connections.append(Connection(initVertex: newEdge.vertexA, initDistance: newEdge.distance!));
            }
        }
    }

    
    func getVertexByName(name: String) -> Vertex?
    {
        for v in vertices
        {
            if(v.name == name)
            {
                return v;
            }
        }
    return nil;
    }
    
    func getVertexById(id: Int) -> Vertex
    {
        return vertices[id];
    }

}
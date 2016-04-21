//
//  OnCampusDirectionsViewController.swift
//  wayfinding test
//
//  Created by Bilsborough, Michael J on 2/11/16.
//  Copyright © 2016 Gonzaga University. All rights reserved.
//

import UIKit
import CoreGraphics

class OnCampusDirectionsViewController: UIViewController, UIScrollViewDelegate
{

    //OUTLETS
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var backArrow: UIButton!
    @IBOutlet var nextArrow: UIButton!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var overviewButton: UIButton!
    @IBOutlet var resumeButton: UIButton!
    @IBOutlet var endButton: UIButton!
    @IBOutlet var topToolbar: UIStackView!
    @IBOutlet var stepsLabel: UILabel!
    @IBOutlet var directionLabel: UILabel!
    @IBOutlet var directionView: UIView!
    
    //Globals
    var graph: Graph?
    var startVertex: Vertex?
    var endVertex: Vertex?
    var path = [Vertex]()
    
    var directions = [Direction]()
    var directionsIndex = 0
    
    let padding = CGFloat(0.3)
    
    var floorView: UIImageView!
    
    var startBuilding = ""
    var startFloor = ""
    var endBuilding = ""
    var endFloor = ""
    var currentBuilding = ""
    var currentFloor = ""
    
    var rotation = CGFloat(0.0)
    
    var startLocation: Directory!
    var endLocation: Directory!
    
    //Actions
    
    @IBAction func overview(sender: UIButton) {
        showOverview()
        swapToResumeButton()
    }
    
    @IBAction func resume(sender: AnyObject) {
        showDirection(directionsIndex)
        swapToOverviewButton()
    }
    
    @IBAction func zoom(sender: AnyObject) {
        showDirection(directionsIndex)
    }
    
    
    @IBAction func end(sender: AnyObject) {
    }
    
    
    @IBAction func start(sender: AnyObject) {
        startButton.hidden = true
        backArrow.hidden = false
        stepsLabel.hidden = false
        nextArrow.hidden = false
        overviewButton.hidden = false
        endButton.hidden = false
        directionView.hidden = false
        
        showDirection(directionsIndex)
    }
    
    
    @IBAction func nextDirection(sender: AnyObject)
    {
        if(directionsIndex < directions.count - 1)
        {
            directionsIndex = directionsIndex + 1
            
            let lastBuilding = currentBuilding;
            currentBuilding = directions[directionsIndex].vertices[0].building;
            
            let lastFloor = currentFloor;
            currentFloor = directions[directionsIndex].vertices[0].floor;
            
            if(currentBuilding != lastBuilding || currentFloor != lastFloor)
            {
                floorView.removeFromSuperview();
                loadFloorView();
            }
            
            updateRotation()
            drawFloor()
            swapToOverviewButton()
            showDirection(directionsIndex)
        }
    }
    
    @IBAction func lastDirection(sender: AnyObject)
    {
        if(directionsIndex > 0)
        {
            directionsIndex = directionsIndex - 1
            
            let lastBuilding = currentBuilding;
            currentBuilding = directions[directionsIndex].vertices[0].building;
            
            let lastFloor = currentFloor;
            currentFloor = directions[directionsIndex].vertices[0].floor;
            
            if(currentBuilding != lastBuilding || currentFloor != lastFloor)
            {
                floorView.removeFromSuperview();
                loadFloorView();
            }
            
            updateRotation()
            drawFloor()
            swapToOverviewButton()
            showDirection(directionsIndex)
        }
    }
    
    func updateRotation()
    {
        let vertices = directions[directionsIndex].vertices
        
        let x1 = vertices[0].x
        let y1 = vertices[0].y
        let x2 = vertices[vertices.count - 1].x
        let y2 = vertices[vertices.count - 1].y
        
        let dy = Double(y2 - y1)
        let dx = Double(x2 - x1)
        
        let angle = -atan2(dy, dx) * 180/M_PI
        
        let fixedAngles = [-270.0, -180.0, -90.0, 0.0, 90.0, 180.0, 270.0]
        
        var smallestDifference = Double.infinity
        var adjustedAngle = 0.0
        for fixedAngle in fixedAngles
        {
            let difference = abs(angle - fixedAngle)
            if(difference < smallestDifference)
            {
                smallestDifference = difference
                adjustedAngle = fixedAngle
            }
        }
        
        if(vertices.count > 1)
        {
            rotation = CGFloat(-adjustedAngle * M_PI/180)
            //floorView.transform = CGAffineTransformMakeRotation(rotation)
        }
    }
    
    func swapToResumeButton()
    {
        overviewButton.hidden = true
        resumeButton.hidden = false
    }
    
    func swapToOverviewButton()
    {
        resumeButton.hidden = true
        overviewButton.hidden = false
    }
    
    func showDirection(directionsIndex: Int)
    {
        stepsLabel.text = String(directionsIndex + 1) + " / " + String(directions.count);
        
        if(directions[directionsIndex].text != "")
        {
            directionView.hidden = false;
            directionLabel.text = directions[directionsIndex].text;
        }
        else
        {
            directionView.hidden = true;
        }
        
        var xArray = [Float]();
        var yArray = [Float]();
        
        for vertex in directions[directionsIndex].vertices
        {
            xArray.append(vertex.x)
            yArray.append(vertex.y)
        }
        
        let leftX = CGFloat(xArray.minElement()!)
        let rightX = CGFloat(xArray.maxElement()!)
        let topY = CGFloat(yArray.minElement()!)
        let botY = CGFloat(yArray.maxElement()!)
        
        let width = rightX - leftX
        let height = botY - topY
        
        let rectX = leftX - scrollView.frame.width * padding
        let rectY = topY - scrollView.frame.height * padding
        let rectWidth = width + 2 * scrollView.frame.width * padding
        let rectHeight = height + 2 * scrollView.frame.height * padding
        
        
        let zoomRect = CGRect(x: rectX, y: rectY, width: rectWidth, height: rectHeight)
        scrollView.zoomToRect(zoomRect, animated: true)
    }
    
    func showOverview()
    {
        scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
    }
    
    func drawFloor()
    {
        for sub in floorView.subviews
        {
            sub.removeFromSuperview()
        }
        loadLineView()
        loadPinsView()
    }
    
    //******************************************************************************************//
    //******************************************************************************************//
    //******************************************************************************************//
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.delegate = self
        
        loadGraph();
        loadPath();
        loadDirectionsLong();
        loadBuildingVariables();
        loadFloorVariables();
        loadToolbars();
    }
    
    override func viewDidAppear(animated: Bool)
    {
        loadFloorView();
        loadLineView();
        loadPinsView();
        scrollView.setZoomScale(scrollView.minimumZoomScale, animated: false)
        centerScrollViewContents();
        
        if(resetToRootView == 1){
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    //******************************************************************************************//
    //******************************************************************************************//
    //******************************************************************************************//
    
    func loadGraph()
    {
        graph = Graph();
        loadTables();
        startVertex = graph!.getVertexByName(startLocation.name);
        endVertex = graph!.getVertexByName(endLocation.name);
    }
    
    func loadPath()
    {
        path = shortestPath(graph!, start: startVertex!, end: endVertex!);
    }
    
    func loadDirectionsLong()
    {
        var directionsIndex = -1
        
        directions.append(Direction())
        directionsIndex += 1;
        directions[directionsIndex].text = "Starting at " + path[0].name;
        directions[directionsIndex].vertices.append(path[0]);
        
        for var i = 1; i < path.count; i++
        {
            if(path[i].floor != path[i - 1].floor || path[i].building != path[i - 1].building)
            {
                var lastIndex = i - 1;
                var nextIndex = i;
                var counter = 0;
                
                while(path[nextIndex].floor != path[lastIndex].floor || path[nextIndex].building != path[lastIndex].building)
                {
                    lastIndex = nextIndex;
                    nextIndex += 1;
                    counter++;
                }
                
                directions.append(Direction())
                directionsIndex += 1
                if(path[i].building != path[i - 1].building)
                {
                    directions[directionsIndex].text = "Continue to " + path[nextIndex].building + " Building";
                }
                else if(path[i].floor != path[i - 1].floor)
                {
                    directions[directionsIndex].text = "Take " + path[i - 1].name + " to Floor " +  path[nextIndex].floor;
                }
                directions[directionsIndex].vertices.append(path[i - 1])
                
                directions.append(Direction())
                directionsIndex += 1
                directions[directionsIndex].text = ""
                directions[directionsIndex].vertices.append(path[lastIndex])
                directions[directionsIndex].vertices.append(path[nextIndex])
                
                i += counter
            }
                
            else
            {
                directions.append(Direction())
                directionsIndex += 1
                directions[directionsIndex].text = ""
                directions[directionsIndex].vertices.append(path[i - 1])
                directions[directionsIndex].vertices.append(path[i])
            }
        }
        
        directions.append(Direction())
        directionsIndex += 1
        directions[directionsIndex].text = "Arrived at " + path[path.count - 1].name;
        directions[directionsIndex].vertices.append(path[path.count - 1]);
        
    }
    
    func loadDirectionsShort()
    {
        var directionsIndex = -1;
        
        directions.append(Direction())
        directionsIndex += 1
        directions[directionsIndex].text = "Starting at " + path[0].name;
        directions[directionsIndex].vertices.append(path[0]);
        
        directions.append(Direction())
        directionsIndex += 1
        directions[directionsIndex].text = ""
        
        //Add first two and get heading
        directions[directionsIndex].vertices.append(path[0])
        directions[directionsIndex].vertices.append(path[1])
        var currentHeading = getHeading(path[0],vertexB: path[1])
        
        for var i = 2; i < path.count; i++
        {
            let newHeading = getHeading(path[i-1],vertexB: path[i])
            print(currentHeading)
            print(newHeading)
            
            if(path[i].floor != path[i - 1].floor || path[i].building != path[i - 1].building)
            {
                var lastIndex = i - 1;
                var nextIndex = i;
                var counter = 0;
                
                while(path[nextIndex].floor != path[lastIndex].floor || path[nextIndex].building != path[lastIndex].building)
                {
                    lastIndex = nextIndex;
                    nextIndex += 1;
                    counter++;
                }
                
                directions.append(Direction())
                directionsIndex += 1
                if(path[i].building != path[i - 1].building)
                {
                    directions[directionsIndex].text = "Continue to " + path[nextIndex].building + "building";
                }
                else if(path[i].floor != path[i - 1].floor)
                {
                    directions[directionsIndex].text = "Take " + path[i - 1].name + " to " + path[nextIndex].building + " " + path[nextIndex].floor;
                }
                directions[directionsIndex].vertices.append(path[i - 1])
                
                directions.append(Direction())
                directionsIndex += 1
                directions[directionsIndex].text = ""
                directions[directionsIndex].vertices.append(path[lastIndex])
                directions[directionsIndex].vertices.append(path[nextIndex])
                var currentHeading = getHeading(path[0],vertexB: path[1])
                
                i += counter
            }
                
            else if(abs(newHeading - currentHeading) > 60)
            {
                directions.append(Direction())
                directionsIndex += 1
                directions[directionsIndex].text = ""
                directions[directionsIndex].vertices.append(path[i - 1])
                directions[directionsIndex].vertices.append(path[i])
                currentHeading = newHeading
            }
                
            else
            {
                directions[directionsIndex].vertices.append(path[i])
            }
        }
        
        directions.append(Direction())
        directionsIndex += 1
        directions[directionsIndex].text = "Arrived at " + path[path.count - 1].name;
        directions[directionsIndex].vertices.append(path[path.count - 1]);
    }
    
    func loadBuildingVariables()
    {
        startBuilding = path[0].building;
        endBuilding = path[path.count - 1].building;
        currentBuilding = path[0].building;
    }
    
    func loadFloorVariables()
    {
        startFloor = path[0].floor;
        endFloor = path[path.count - 1].floor;
        currentFloor = path[0].floor;
    }
    
    func loadToolbars()
    {
        backArrow.hidden = true
        nextArrow.hidden = true
        stepsLabel.hidden = true
        overviewButton.hidden = true
        resumeButton.hidden = true
        endButton.hidden = true
        directionView.hidden = true;
    }
    
    func loadFloorView()
    {
        let imageName = "data/" + currentBuilding + "_" + currentFloor + ".png"
        let image = UIImage(named: imageName)!
        floorView = UIImageView(image: image)
        floorView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size:image.size)
        scrollView.addSubview(floorView)
        scrollView.contentSize = floorView.frame.size
        
        let scaleWidth = scrollView.frame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollView.frame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight)
        scrollView.minimumZoomScale = minScale
        
        scrollView.maximumZoomScale = 1.0
        
        centerScrollViewContents()
    }
    
    func loadLineView()
    {
        let newLineView = lineView(frame: CGRectMake(0, 0, floorView.image!.size.width, floorView.image!.size.height),  directions: directions, currentDirectionsIndex: directionsIndex)
        floorView.addSubview(newLineView)
    }
    
    func loadPinsView()
    {
        //Start Pin
        if(currentBuilding == startBuilding && currentFloor == startFloor)
        {
            let image = UIImage(named: "start")!
            let endPin = UIImageView(image: image)
            let vertexX = startVertex!.x
            let vertexY = startVertex!.y
            let x = CGFloat(vertexX) - image.size.width / 2
            let y = CGFloat(vertexY) - image.size.height
            endPin.frame = CGRect(origin: CGPoint(x: x, y: y), size:image.size)
            floorView.addSubview(endPin)
        }

        //End Pin
        if(currentBuilding == endBuilding && currentFloor == endFloor)
        {
            let image = UIImage(named: "end")!
            let endPin = UIImageView(image: image)
            let vertexX = endVertex!.x
            let vertexY = endVertex!.y
            let x = CGFloat(vertexX) - image.size.width / 2
            let y = CGFloat(vertexY) - image.size.height
            endPin.frame = CGRect(origin: CGPoint(x: x, y: y), size:image.size)
            floorView.addSubview(endPin)
        }
        
        //Current Position Pin
        let image = UIImage(named: "current")!
        let startPin = UIImageView(image: image)
        let vertexX = directions[directionsIndex].vertices[0].x
        let vertexY = directions[directionsIndex].vertices[0].y
        let x = CGFloat(vertexX) - image.size.width / 2
        let y = CGFloat(vertexY) - image.size.height
        startPin.frame = CGRect(origin: CGPoint(x: x, y: y), size:image.size)
        floorView.addSubview(startPin)
    }
    
    func getHeading(vertexA: Vertex, vertexB: Vertex) -> Float
    {
        let deltaY = vertexB.y - vertexA.y
        let deltaX = vertexB.x - vertexA.x
        var angle = atan2(deltaY, deltaX) * 180.0 / Float(M_PI)
        if(angle < 0)
        {
            angle += 360
        }
        return angle
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
    {
        return floorView
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        overviewButton.hidden = true
        resumeButton.hidden = false
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //overviewButton.hidden = true
        //resumeButton.hidden = false
    }
    
    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contentsFrame = floorView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        floorView.frame = contentsFrame
    }

    func loadTables()
    {
        let fileVertices = NSBundle.mainBundle().pathForResource("data/vertices", ofType: "csv")!
        let fileEdges = NSBundle.mainBundle().pathForResource("data/edges", ofType: "csv")!
        
        let error: NSErrorPointer = nil
        
        let tableVertices = CSV(contentsOfFile: fileVertices, error: error);
        let tableEdges = CSV(contentsOfFile: fileEdges, error: error);
        
        //Vertices
        for row in tableVertices!.rows
        {
            let id = row["ID"]!;
            let name = row["Name"]!;
            let x = row["X"]!;
            let y = row["Y"]!;
            let building = row["Building"]!;
            let floor = row["Floor"]!;
            graph!.addVertex(Vertex(initId: Int(id)!, initName: String(name), initX: Float(x)!, initY: Float(y)!, initBuilding: String(building), initFloor: String(floor)));
        }
        
        //Edges
        for row in tableEdges!.rows
        {
            let vertexAId = Int(row["Vertex A ID"]!)!;
            let vertexBId = Int(row["Vertex B ID"]!)!;
            let vertexA = graph?.getVertexById(vertexAId);
            let vertexB = graph?.getVertexById(vertexBId);
            graph!.addEdge(Edge(initVertexA: vertexA!, initVertexB: vertexB!));
        }
    }
    
    func shortestPath(g: Graph, start: Vertex, end: Vertex) -> [Vertex]
    {
        var current = start;
    
        for v in g.vertices
        {
            if(v.id == start.id)
            {
                v.visited = true;
                v.pathDistance = 0;
            }
            else
            {
                v.visited = false;
                v.pathDistance = 2147483647; //MAX_INT
            }
        }
    
        while(end.visited == false)
        {
            updateDistances(current);
            current = getNext(g);
        }
    
        return computePath(end);
    }
    
    func updateDistances(current: Vertex)
    {
        for c in current.connections
        {
            let neighbor = c.vertex;
            if(neighbor.visited == false)
            {
                let newNeighborPathDistance = current.pathDistance! + c.distance;
                if(newNeighborPathDistance < neighbor.pathDistance)
                {
                    neighbor.pathDistance = newNeighborPathDistance;
                    neighbor.previous = current;
                }
            }
        }
    }
    
    func getNext(g: Graph) -> Vertex
    {
        var next: Vertex?;
        var minPathDistance = Float(2147483647);
        for v in g.vertices
        {
            if(v.visited == false && v.pathDistance! < minPathDistance)
            {
                minPathDistance = v.pathDistance!;
                next = v;
            }
        }
        if(next != nil)
        {
            next!.visited = true;
        }
        return next!;
    }
    
    func computePath(end: Vertex) -> [Vertex]
    {
        var reversedPath = [Vertex]();
        var current = end;
        while(current.previous != nil)
        {
            reversedPath.append(current);
            current = current.previous!;
        }
    
        reversedPath.append(current);
    
        for var i = reversedPath.count - 1; i >= 0; i--
        {
            path.append(reversedPath[i]);
        }
    
        return path;
    }
    
    func printPath(path: [Vertex])
    {
        print("Path");
        for v in path
        {
            print(v.name);
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

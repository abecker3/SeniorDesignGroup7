//Michael Bilsborough
//Dijkstra's Shortest Path

Graph graph = new Graph();
PImage floorMap;

String startVertex;
String endVertex;

Component selectedComponent;

int resizeFactor = 3;

ArrayList<Building> buildings = new ArrayList<Building>();

int buildingIndex;
int floorIndex;
String currentBuilding;
String currentFloor;

String textMode;
int textSize;
PFont font;

void setup()
{
  buildingIndex = 0;
  floorIndex = 0;
  loadBuildings();
  currentBuilding = buildings.get(buildingIndex).name;
  currentFloor = buildings.get(buildingIndex).floors.get(floorIndex);
  loadFloor();

  startVertex = "A";
  endVertex = "B";
  
  selectedComponent = null;
  
  loadGraph();
  
  textMode = "NAME";
  textSize = 20;
  font = createFont("Arial Bold", textSize);
  textFont(font);
  
  checkGraph();
}

void checkGraph()
{
  for(Vertex start : graph.vertices)
  {
    for(Vertex end: graph.vertices)
    {
      Graph graphCopy = graph;
      Vertex startCopy = start;
      Vertex endCopy = end;
      shortestPath(graphCopy, startCopy, endCopy);
      println("Start ID: " + start.id + "  End ID: " + end.id + "  Success");
    }
  }
}

void loadBuildings()
{
  Building mainTower = new Building("Main Tower");
  mainTower.floors.add("L6");
  mainTower.floors.add("L5");
  mainTower.floors.add("L4");
  mainTower.floors.add("UL4");
  mainTower.floors.add("L3");
  mainTower.floors.add("L2");
  mainTower.floors.add("L1");
  mainTower.floors.add("Main");
  mainTower.floors.add("2");
  mainTower.floors.add("3");
  mainTower.floors.add("4");
  mainTower.floors.add("5");
  mainTower.floors.add("6");
  mainTower.floors.add("7");
  mainTower.floors.add("8");
  mainTower.floors.add("9");
  mainTower.floors.add("10");
  
  Building heart = new Building("Heart Institute");
  heart.floors.add("1");
  heart.floors.add("2");
  heart.floors.add("3");
  heart.floors.add("4");
  heart.floors.add("5");
  
  Building heartParking = new Building("Heart Parking");
  heartParking.floors.add("P1");
  heartParking.floors.add("P2");
  heartParking.floors.add("P3");
  heartParking.floors.add("P4");
  heartParking.floors.add("P5");
  
  Building doctors = new Building("Doctors Building");
  doctors.floors.add("Main");
  doctors.floors.add("C");
  doctors.floors.add("D");
  doctors.floors.add("E");
  doctors.floors.add("F");
  doctors.floors.add("5");
  doctors.floors.add("6");
  doctors.floors.add("7");
  
  Building womensParking = new Building("Women's Parking");
  womensParking.floors.add("P2");
  womensParking.floors.add("P3");
  womensParking.floors.add("P4");
  womensParking.floors.add("P5");
  womensParking.floors.add("P6");
  
  buildings.add(mainTower);
  buildings.add(heart);
  buildings.add(heartParking);
  buildings.add(doctors);
  buildings.add(womensParking);
}

void loadFloor()
{
  floorMap = loadImage(currentBuilding + "_" + currentFloor + ".png");
  floorMap.resize(floorMap.width/resizeFactor, floorMap.height/resizeFactor);
  surface.setSize(floorMap.width, floorMap.height);
}

void loadGraph()
{
  File fileVertices = new File(dataPath("vertices.csv"));
  File fileEdges = new File(dataPath("edges.csv"));
  
  //Vertices
  if(fileVertices.exists())
  {
    Table tableVertices = loadTable("vertices.csv", "header");
    for(int i = 0; i < tableVertices.getRowCount(); i++)
    {
      TableRow row = tableVertices.getRow(i);
      graph.addVertex(new Vertex(row.getInt("ID"), 
                      row.getString("Name"), 
                      row.getFloat("X")/resizeFactor, 
                      row.getFloat("Y")/resizeFactor, 
                      row.getString("Building"), 
                      row.getString("Floor"), 
                      row.getString("Category"),
                      row.getString("Hours"),
                      row.getInt("Ext"),
                      row.getString("Notes")));
    }
  }
  
  //Edges
  if(fileEdges.exists())
  {
    Table tableEdges = loadTable("edges.csv", "header");
    for(int i = 0; i < tableEdges.getRowCount(); i++)
    {
      TableRow row = tableEdges.getRow(i);
      Vertex vertexA = graph.getVertexById(row.getInt("Vertex A ID"));
      Vertex vertexB = graph.getVertexById(row.getInt("Vertex B ID"));
      graph.addEdge(new Edge(vertexA, vertexB));
    }
  }
}

void draw()
{
   background(floorMap);
   graph.drawGraph(currentBuilding, currentFloor);
   
   textSize(textSize);
   printBuildingAndFloor();
   printSelected();
   printTextMode();
}

void printTextMode()
{
  if(textMode == "NONE")
  {
    //Do Nothing
  }
  else if(textMode == "ID")
  { 
    graph.printID(currentBuilding, currentFloor);
  }
  else if(textMode == "NAME")
  { 
    graph.printName(currentBuilding, currentFloor);
  }
}

void printSelected()
{
   String t;
   textAlign(LEFT);
   if(selectedComponent == null)
   {
     t = "NULL";
   }
   else
   {
     t = selectedComponent.type;
   }
   text(t, 0, height);
}

void printBuildingAndFloor()
{
  fill(0);
  stroke(0);
  textAlign(RIGHT);
  text(currentBuilding + " " + currentFloor, width, height);
}

void shortestPath(Graph g, Vertex start, Vertex end)
{
  Vertex current = start;
  ArrayList<Vertex> path = new ArrayList<Vertex>();
  
  for(Vertex v : g.vertices)
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
  
  while(!end.visited)
  {
    updateDistances(current);
    current = getNext(g);
  }
  
  //printPrevious(g);
  //println();
  //path = computePath(end);
  //println();
  //printPath(path);
}
  
void updateDistances(Vertex current)
{
  for(Connection c : current.connections)
  {
    Vertex neighbor = c.vertex;
    if(!neighbor.visited)
    {
      float newNeighborPathDistance = current.pathDistance + c.distance;
      if(newNeighborPathDistance < neighbor.pathDistance)
      {
        neighbor.pathDistance = newNeighborPathDistance;
        neighbor.previous = current;
      }
    }
  }
}
  
Vertex getNext(Graph g)
{
  Vertex next = null;
  float minPathDistance = 2147483647;
  for(Vertex v: g.vertices)
  {
    if(!v.visited && v.pathDistance < minPathDistance)
    {
      minPathDistance = v.pathDistance;
      next = v; 
    }
  }
  if(next != null)
  {
    next.visited = true;
  }
  return next;
}

Boolean allVerticesVisited(Graph g)
{
  for(Vertex v: g.vertices)
  {
    if(!v.visited)
    {
      return false;
    }
  }
  return true;
}

ArrayList<Vertex> computePath(Vertex end)
{
  ArrayList<Vertex> reversedPath = new ArrayList<Vertex>();
  ArrayList<Vertex> path = new ArrayList<Vertex>();
  Vertex current = end;
  while(current.previous != null)
  {
    reversedPath.add(current);
    current = current.previous;
  }
  
  reversedPath.add(current);
  
  for(int i = reversedPath.size() - 1; i >= 0; i--)
  {
    path.add(reversedPath.get(i));
  }
  
  return path;
}

void printPath(ArrayList<Vertex> path)
{
  println("Path");
  for(Vertex v: path)
  {
    println(v.id);
  }
}

void printPrevious(Graph g)
{
  println("Previous List");
  for(Vertex v : g.vertices)
  {
    if(v.previous == null)
    {
      println(v.name, ": null");
    }
    else
    {
      println(v.name, ": ", v.previous.name);
    }
  }
}

void mouseClicked()
{
  //Nothing Previously Selected
  if(selectedComponent == null)
  {
    //Clicked Vertex
    if(clickedOnVertex())
    {
      //Select Vertex
      selectedComponent = clickedVertex();
      selectedComponent.selected = true;
    }
    //Clicked Edge
    else if(clickedOnEdge())
    {
      //Select Edge
       selectedComponent = clickedEdge();
       selectedComponent.selected = true;
    }
    //Clicked Nothing
    else
    {
      //Create Vertex
      graph.addVertex(new Vertex(graph.vertices.size(), "", mouseX, mouseY, currentBuilding, currentFloor, "", "", 0, ""));
      print("Added Vertex: " + graph.vertices.size() + "  " + mouseX + "  " + mouseY + "  " + currentBuilding + "  " + currentFloor);
    }
  }
  
  //Vertex Previously Selected
  else if(selectedComponent.type.equals("Vertex"))
  {
    Vertex selectedVertex = (Vertex) selectedComponent;
    
    //Clicked Vertex
    if(clickedOnVertex())
    {
      //Add Edge
      Vertex otherVertex = clickedVertex();
      if(graph.edgeExists(selectedVertex, otherVertex))
      {
        print("Edge Already Exists");
      }
      else if(selectedVertex == otherVertex)
      {
        print("Failed Add Edge: Same Vertex");
      }
      else
      {
        graph.addEdge(new Edge(selectedVertex, otherVertex));
        print("Added Edge: " + selectedVertex.id + "  " + otherVertex.id);
        selectedComponent.selected = false;
        selectedComponent = null;
      }
    }
    //Clicked Edge
    else if(clickedOnEdge())
    {
      //Select Edge
      selectedComponent.selected = false;
      selectedComponent = clickedEdge();
      selectedComponent.selected = true;
    }
    //Clicked Nothing
    else
    {
      //Move Vertex
      selectedVertex.x = mouseX;
      selectedVertex.y = mouseY;
    }
  }
  
  //Edge Previously Selected
  else if(selectedComponent.type.equals("Edge"))
  {
    Edge selectedEdge = (Edge) selectedComponent;
    
    //Clicked Vertex
    if(clickedOnVertex())
    {
      //Select Vertex
      selectedComponent.selected = false;
      selectedComponent = clickedVertex();
      selectedComponent.selected = true;
    }
    //Clicked Edge
    else if(clickedOnEdge())
    {
      //Select Edge
      selectedComponent.selected = false;
      selectedComponent = clickedEdge();
      selectedComponent.selected = true;
    }
    //Clicked Nothing
    else
    {
      //Do Nothing
    }
  }
}

Boolean clickedOnEdge()
{
  
  for (Edge e : graph.floorEdges(currentBuilding, currentFloor))
  {
    float tolerance  = 10;
    
    float m = (e.vertex2.y - e.vertex1.y) / (e.vertex2.x - e.vertex1.x);
    float b = e.vertex1.y - m * e.vertex1.x;
    
    float y = m * mouseX + b;
    float dif = abs(y - mouseY);
    
    float leftX = min(e.vertex1.x, e.vertex2.x);
    float rightX = max(e.vertex1.x, e.vertex2.x);
    float topY = min(e.vertex1.y, e.vertex2.y);
    float botY = max(e.vertex1.y, e.vertex2.y);
    
    if(abs(leftX - rightX) <= tolerance)  //Vertical Line
    {
      if(abs(leftX - mouseX) <= tolerance && mouseY >= topY && mouseY <= botY)
      {
        return true;
      }
    }
    
    else if(dif < tolerance && mouseX >= leftX && mouseX <= rightX)
    {
      return true;
    }
  }
  return false;
}

Edge clickedEdge()
{
  for (Edge e : graph.floorEdges(currentBuilding, currentFloor))
  {
    float tolerance  = 10;
    
    float m = (e.vertex2.y - e.vertex1.y) / (e.vertex2.x - e.vertex1.x);
    float b = e.vertex1.y - m * e.vertex1.x;
    
    float y = m * mouseX + b;
    float dif = abs(y - mouseY);
    
    float leftX = min(e.vertex1.x, e.vertex2.x);
    float rightX = max(e.vertex1.x, e.vertex2.x);
    float topY = min(e.vertex1.y, e.vertex2.y);
    float botY = max(e.vertex1.y, e.vertex2.y);
    
    if(abs(leftX - rightX) <= tolerance)  //Vertical Line
    {
      if(abs(leftX - mouseX) <= tolerance && mouseY >= topY && mouseY <= botY)
      {
        return e;
      }
    }
    
    else if(dif < tolerance && mouseX >= leftX && mouseX <= rightX)
    {
      return e;
    }
  }
  return null;
}

Boolean clickedOnVertex()
{
  for (Vertex v : graph.floorVertices(currentBuilding, currentFloor))
  {
    if(mouseX > v.x - graph.vertexSize/2 && mouseX < v.x + graph.vertexSize/2 && mouseY > v.y - graph.vertexSize/2  && mouseY < v.y + graph.vertexSize/2)
    {
      return true;
    }
  }
  return false;
}

Vertex clickedVertex()
{
  for (Vertex v : graph.floorVertices(currentBuilding, currentFloor))
  {
    if(mouseX > v.x - graph.vertexSize/2 && mouseX < v.x + graph.vertexSize/2 && mouseY > v.y - graph.vertexSize/2  && mouseY < v.y + graph.vertexSize/2)
    {
      return v;
    }
  }
  return null;
}

void keyPressed()
{
  if(selectedComponent != null)
  {
    if(selectedComponent.type.equals("Vertex"))
    {
      Vertex selectedVertex = (Vertex) selectedComponent;
      
      if(key == ESC)
      {
        key = 0;
        selectedComponent.selected = false;
        selectedComponent = null;
      }
      
      else if(keyCode == LEFT && buildingIndex > 0)
      {
        buildingIndex -= 1;
        floorIndex = 0;
        currentBuilding = buildings.get(buildingIndex).name;
        currentFloor = buildings.get(buildingIndex).floors.get(floorIndex);
        loadFloor();
      }
      
      else if(keyCode == RIGHT && buildingIndex < buildings.size() - 1)
      {
        buildingIndex += 1;
        floorIndex = 0;
        currentBuilding = buildings.get(buildingIndex).name;
        currentFloor = buildings.get(buildingIndex).floors.get(floorIndex);
        loadFloor();
      }
      
      else if(keyCode == UP && floorIndex < buildings.get(buildingIndex).floors.size() - 1)
      {
        floorIndex += 1;
        currentFloor = buildings.get(buildingIndex).floors.get(floorIndex);
        loadFloor();
      }
      
      else if(keyCode == DOWN && floorIndex > 0)
      {
        floorIndex -= 1;
        currentFloor = buildings.get(buildingIndex).floors.get(floorIndex);
        loadFloor();
      }
      
      else if(key == DELETE)
      {
        if(graph.removeVertex(selectedVertex))
        {
          graph.orderVertices();
          selectedComponent = null;
        }
      }
      
      else if(key == TAB) //END
      {
        graph.removeAttachedEdges(selectedVertex);
      }
      
      else if(key == RETURN || key == ENTER)
      {
        selectedComponent.selected = false;
        selectedComponent = null;
      }
      else if (key == BACKSPACE)
      {
        if(selectedVertex.name.length() > 0)
        {
          selectedVertex.name = selectedVertex.name.substring(0, selectedVertex.name.length() - 1);
        }
      }
      else if (keyCode != SHIFT)
      {
        selectedVertex.name += key;
      }
    }
    
    else if(selectedComponent.type.equals("Edge"))
    {
      Edge selectedEdge = (Edge) selectedComponent;
      
      if(key == ESC)
      {
        key = 0;
        selectedComponent.selected = false;
        selectedComponent = null;
      }
      
      if(key == DELETE)
      {
        graph.removeEdge(selectedEdge);
        selectedComponent = null;
      }
    }
  }
  else
  {
    if(keyCode == LEFT && buildingIndex > 0)
    {
      buildingIndex -= 1;
      floorIndex = 0;
      currentBuilding = buildings.get(buildingIndex).name;
      currentFloor = buildings.get(buildingIndex).floors.get(floorIndex);
      loadFloor();
    }
      
    else if(keyCode == RIGHT && buildingIndex < buildings.size() - 1)
    {
      buildingIndex += 1;
      floorIndex = 0;
      currentBuilding = buildings.get(buildingIndex).name;
      currentFloor = buildings.get(buildingIndex).floors.get(floorIndex);
      loadFloor();
    }
      
    else if(keyCode == UP && floorIndex < buildings.get(buildingIndex).floors.size() - 1)
    {
      floorIndex += 1;
      currentFloor = buildings.get(buildingIndex).floors.get(floorIndex);
      loadFloor();
    }
      
    else if(keyCode == DOWN && floorIndex > 0)
    {
      floorIndex -= 1;
      currentFloor = buildings.get(buildingIndex).floors.get(floorIndex);
      loadFloor();
    }
    if(key == 49) //1
  {
    textMode = "NONE";
  }
  if(key == 50) //2
  {
    textMode = "ID";
  }
  if(key == 51) //3
  {
    textMode = "NAME";
  }
  if(key == 61) //+
  {
    textSize += 1;
  }
  if(key == 45) //-
  {
    if(textSize > 0)
    {
      textSize -= 1;
    }
  }
 }
  if(key == 19) //CTRL-S
  {
    saveGraph();
  }
  
  if(key == ESC)
  {
    key = 0;
  }
}

void saveGraph()
{
  println("Graph Saved");
  for(Vertex v: graph.vertices)
  {
    v.x *= resizeFactor;
    v.y *= resizeFactor;
  }
  graph.orderVertices();
  saveTable(graph.exportVertices(), "data/" + "vertices.csv");
  saveTable(graph.exportEdges(), "data/" + "edges.csv");
  for(Vertex v: graph.vertices)
  {
    v.x /= resizeFactor;
    v.y /= resizeFactor;
  }
}
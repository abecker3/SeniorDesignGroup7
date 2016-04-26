class Graph
{
  ArrayList<Vertex> vertices;
  ArrayList<Edge> edges;
  float vertexSize;

  Graph()
  {
    vertices = new ArrayList<Vertex>();
    edges = new ArrayList<Edge>();
    vertexSize = 10;
  }

  void printName(String building, String floor)
  {
    fill(0);
    textAlign(CENTER);
    for(Vertex v : floorVertices(building, floor))
    {
      fill(0);
      text(v.name, v.x, v.y);
    }
  }
  
  void printID(String building, String floor)
  {
    fill(0);
    textAlign(CENTER);
    for(Vertex v : floorVertices(building, floor))
    {
      fill(0);
      text(v.id, v.x, v.y);
    }
  }

  void drawGraph(String currentBuilding, String currentFloor)
  {
    for (Vertex v : vertices)
    {
      textAlign(CENTER, CENTER);
      if(v.building.equals(currentBuilding) && v.floor.equals(currentFloor))
      {  
        if(v.selected)
        {
          stroke(255, 0, 0);
          fill(255, 255, 0);
        }

        else
        {
          stroke(255, 0, 0);
          fill(255, 0, 0);
        }
        
        for(Connection c : v.connections)
        {
          if(!v.floor.equals(c.vertex.floor))
          {
            fill(0, 255, 0);
          }
        }
        
        ellipse(v.x, v.y, vertexSize, vertexSize);
      }
    }
    
    for (Edge e : edges)
    {
      if(e.vertex1.building.equals(currentBuilding) && e.vertex2.building.equals(currentBuilding) && e.vertex1.floor.equals(currentFloor) && e.vertex2.floor.equals(currentFloor))
      {
        if(e.selected)
        {
          stroke(255, 255, 0);
        }
        else
        {
          stroke(255, 0, 0);
        }
        line(e.vertex1.x, e.vertex1.y, e.vertex2.x, e.vertex2.y);
      }
    }
  }

  void addVertex(Vertex newVertex)
  {
    vertices.add(newVertex);
  }

  void addEdge(Edge newEdge)
  {
    edges.add(newEdge);
    
    for (Vertex v : vertices)
    {
      if (v.id == newEdge.vertex1.id)
      {
        v.connections.add(new Connection(newEdge.vertex2, newEdge.distance));
      }
      else if (v.id == newEdge.vertex2.id)
      {
        v.connections.add(new Connection(newEdge.vertex1, newEdge.distance));
      }
    }
  }
  
  boolean removeVertex(Vertex v)
  {
    if(vertices.size() > 0)
    {
      if(v.connections.size() == 0)
      {
        vertices.remove(v);
        return true;
      }
      else
      {
        println("Cannot Delete Vertex: Connections Exist");
        return false;
      }
    }
    return false;
  }
  
  void removeEdge(Edge e)
  {
    if(edges.size() > 0)
    {
      for (Vertex v : vertices)
      {
        v.removeConnection(e.vertex1);
        v.removeConnection(e.vertex2);
      }
      edges.remove(e);
    }
  }

  Vertex getVertexByName(String name)
  {
    for (Vertex v : vertices)
    {
      if(v.name.equals(name))
      {
        return v;
      }
    }
    return null;
  }
  
  Vertex getVertexById(int id)
  {
    return vertices.get(id);
  }
  
  Boolean edgeExists(Vertex a, Vertex b)
  {
    for(Edge e: edges)
    {
      if((e.vertex1 == a && e.vertex2 == b) || (e.vertex1 == b && e.vertex2 == a))
      {
        return true;
      }
    }
    return false;
  }
  
  void removeAttachedEdges(Vertex v)
  {
    int counter = 0;
    ArrayList<Edge> edgesToRemove = new ArrayList<Edge>();
    
    for(Edge e: edges)
    {
      if((e.vertex1 == v || e.vertex2 == v))
      {
        edgesToRemove.add(e);
        counter += 1;
      }
    }
    for(Edge e: edgesToRemove)
    {
      removeEdge(e);
    }
    print("Removed " + counter + " Edges");
  }
  
  ArrayList<Vertex> floorVertices(String building, String floor)
  {
    ArrayList<Vertex> floorVertices = new ArrayList<Vertex>();
    
    for(Vertex v: vertices)
    {
      if(v.building.equals(building) && v.floor.equals(floor))
      {
        floorVertices.add(v);
      }
    }
    
    return floorVertices;
  }
  
  ArrayList<Edge> floorEdges(String building, String floor)
  {
    ArrayList<Edge> floorEdges = new ArrayList<Edge>();
    
    for(Edge e: edges)
    {
      if(e.vertex1.building.equals(building) && e.vertex1.floor.equals(floor))
      {
        floorEdges.add(e);
      }
    }
    
    return floorEdges;
  }
  
  void orderVertices()
  {
    for(int i = 0; i < vertices.size(); i++)
    {
      vertices.get(i).id = i;
    }
  }
  
  Table exportVertices()
  {
    Table table = new Table();
    table.addColumn("ID");
    table.addColumn("Name");
    table.addColumn("X");
    table.addColumn("Y");
    table.addColumn("Building");
    table.addColumn("Floor");
    table.addColumn("Category");
    table.addColumn("Hours");
    table.addColumn("Ext");
    table.addColumn("Notes");
    
    for(Vertex v: vertices)
    {
      TableRow newRow = table.addRow();
      newRow.setInt("ID", v.id);
      newRow.setString("Name", v.name);
      newRow.setFloat("X", v.x);
      newRow.setFloat("Y", v.y);
      newRow.setString("Building", v.building);
      newRow.setString("Floor", v.floor);
      newRow.setString("Category", v.category);
      newRow.setString("Hours", v.hours);
      newRow.setInt("Ext", v.ext);
      newRow.setString("Notes", v.notes);
    }
    return table;
  }
  
  Table exportEdges()
  {
    Table table = new Table();
    table.addColumn("Vertex A ID");
    table.addColumn("Vertex B ID");
    
    for(Edge e: edges)
    {
      TableRow newRow = table.addRow();
      newRow.setInt("Vertex A ID", e.vertex1.id);
      newRow.setInt("Vertex B ID", e.vertex2.id);
    }
    return table;
  }
}
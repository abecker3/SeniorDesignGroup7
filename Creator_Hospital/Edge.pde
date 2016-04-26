class Edge extends Component
{
  Vertex vertex1;
  Vertex vertex2;
  float distance;
  
  Edge(Vertex initVertex1, Vertex initVertex2)
  {
    super("Edge");
    vertex1 = initVertex1;
    vertex2 = initVertex2;
    distance = calcDistance(initVertex1, initVertex2);
  }
  
  float calcDistance(Vertex start, Vertex end)
  {
    float d;
    
    if(vertex1.floor.equals(vertex2.floor))
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
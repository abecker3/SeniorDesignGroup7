class Vertex extends Component
{
  int id;
  String name;
  String category;
  float x;
  float y;
  String hours;
  int ext;
  String notes;
  String building;
  String floor;
  float pathDistance;
  Boolean visited;
  ArrayList<Connection> connections;
  Vertex previous;

  Vertex(int initId, String initName, float initX, float initY, String initBuilding, String initFloor, String initCategory, String initHours, int initExt, String initNotes)
  {
    super("Vertex");
    id = initId;
    name = initName;
    x = initX;
    y = initY;
    building = initBuilding;
    floor = initFloor;
    connections = new ArrayList<Connection>();
    previous = null;
    
    category = initCategory;
    hours = initHours;
    ext = initExt;
    notes = initNotes;
  }
  
  void removeConnection(Vertex v)
  {
    for(Connection c: connections)
    {
      if(c.vertex == v)
      {
        connections.remove(c);
        break;
      }
    }
  }
}
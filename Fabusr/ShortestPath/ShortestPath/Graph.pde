import java.util.Vector;

public class Graph
{
  private Vector<Vertex> vertices;
  private Vector<Edge> edges;  
  private final static int OVERLAP_RETRIES = 5;   


  public Graph(int countVertices, int countEdges)
  {    
    vertices = new Vector<Vertex>();
    edges = new Vector<Edge>();
    generateVertices(countVertices);
    generateEdges(countEdges);
  }

  public Vector<Vertex> getVertices()
  {
    return this.vertices;
  }

  public Vector<Edge> getEdges()
  {
    return this.edges;
  }     

  private void generateVertices(int countVertices)
  {
    int vertexID = 1;
    for (int i = 0; i < countVertices; i++)
    {      
      int overlapFails = 0; 
      boolean addedVertex = false;           
      while (!addedVertex && overlapFails <= OVERLAP_RETRIES)
      {
        overlapFails++;
        int randomX = (int) random(Vertex.SIZE, WINDOW_SIZE - Vertex.SIZE);
        int randomY = (int) random(Vertex.SIZE, WINDOW_SIZE - Vertex.SIZE);
        if (!isColliding(randomX, randomY))
        {
          vertices.add(new Vertex(vertexID, randomX, randomY));
          vertexID++;
          addedVertex = true;
        }
      }
    }
  }

  private void generateEdges(int countEdges)
  {
    int edgeID = 1;
    for (int i = 0; i < countEdges; i++)
    {
      boolean edgeAlreadyExists = true;      
      while (edgeAlreadyExists)
      {        
        Vertex v1 = this.getAnyVertex();
        Vertex v2 = this.getAnyVertex();

        if (v1 != v2) {
          edgeAlreadyExists = false;
          for (Edge edge : this.edges)
          {
            if (((edge.getSource() == v1) && (edge.getDestination() == v2)) ||
              ((edge.getSource() == v2) && (edge.getDestination() == v1)))
            {
              edgeAlreadyExists = true;
            }
          }

          if (!edgeAlreadyExists) {
            Edge e = new Edge(edgeID, v1, v2);
            edgeID++;
            this.edges.add(e);
          }
        }
      }
    }
  }

  public Vertex getAnyVertex()
  {
    int randomIndex = (int) random(0, this.vertices.size());
    println(randomIndex);
    return vertices.get(randomIndex);
  }   

  public void display()
  {
    for (Vertex vertex : vertices)
    {
      vertex.display();
    }

    for (Edge edge : edges)
    {
      edge.display();
    }
  }

  public boolean isColliding(int x, int y)
  {       
    for (Vertex v : this.vertices)
    {     
      int xMax = v.getX() + Vertex.SIZE;
      int xMin = v.getX() - Vertex.SIZE;
      int yMax = v.getY() + Vertex.SIZE;
      int yMin = v.getY() - Vertex.SIZE;                
      if ((x < xMax && x > xMin) ||
        y < yMax && y > yMin)
      {
        return true;
      }
    }    
    return false;
  }
  
  public Vertex getCollidingVertex(int x, int y)
  {       
    for (Vertex v : this.vertices)
    {     
      int xMax = v.getX() + Vertex.SIZE;
      int xMin = v.getX() - Vertex.SIZE;
      int yMax = v.getY() + Vertex.SIZE;
      int yMin = v.getY() - Vertex.SIZE;                
      if ((x < xMax && x > xMin) ||
        y < yMax && y > yMin)
      {
        return v;
      }
    }    
    return null;
  }
  
  
}
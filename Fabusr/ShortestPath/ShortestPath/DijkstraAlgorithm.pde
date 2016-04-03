public class DijkstraAlgorithm
{

  private Vertex sourceVertex;
  private Vertex destVertex;
  private Queue<Vertex> queue;

  public Vector<Vertex> getShortestPath(Graph graph)
  {
    this.initialise();    

    while (!queue.isEmpty())
    {
      Vertex vertex = queue.remove(); //current vertex with smallest distance from source      
      for (Edge e : graph.getEdges())
      {
        Vertex neighbour = null;
        if (e.getSource() == vertex)
        {
          neighbour = e.getDestination();
        }          
        if (e.getDestination() == vertex)
        {
          neighbour = e.getSource();
        }


        if (neighbour != null)
        {
          int alternativeDistance = vertex.getDistance() + e.getWeight();
          if (alternativeDistance < neighbour.getDistance())
          {
            queue.remove(neighbour);
            neighbour.setDistance(alternativeDistance);
            neighbour.setPrevious(vertex);
            queue.add(neighbour);
            println("vertex: " + vertex.getId() + "neighbour: " + neighbour.getId() + "alt: " + alternativeDistance + " neighbour dist: " + neighbour.getDistance());
          }
        }
      }
    }

    Vector<Vertex> shortestPath = new Vector<Vertex>();        
    Vertex v = destVertex;
    while (v.getPrevious() != null)
    {
      shortestPath.add(v);
      v = v.getPrevious();
    }

    return shortestPath;
  }


  private void initialise()
  {
    queue = new PriorityQueue<Vertex>();
    for (Vertex v : graph.getVertices())
    {
      if (v.isStart)
      {
        sourceVertex = v;
        v.setDistance(0);
      } else {
        v.setDistance(10000000);
      }

      if (v.isDestination)
      {
        destVertex = v;
      }

      queue.add(v);
    }
  }
}
import java.util.Stack;
import java.util.PriorityQueue;
import java.util.Queue;
public static final int WINDOW_SIZE = 500;

//private static final ShortestPathAlgorithm algorithm = ShortestPathAlgorithm.DIJKSTRA;
private Graph graph;
private static final int COUNT_EDGES = 8;
private static final int COUNT_VERTICES = 10;
private State state;
private String displayText;
private DijkstraAlgorithm algorithm;
private Vector<Vertex> shortestPath;

void setup()
{
  size(500, 500, P3D);  
  fill(255, 255, 0);
  //Graph graph = new Graph(COUNT_VERTICES, COUNT_EDGES);
  graph = new Graph(COUNT_VERTICES, COUNT_EDGES);
  graph.display();
  this.state = State.ChooseStart;
  displayText = "choose a start";  
  background(255);  
  graph.display();
  text(displayText, 30, 30);
}

void mousePressed()
{
  Vertex v = graph.getCollidingVertex(mouseX, mouseY);
  if (v != null)
  {
    switch(this.state)
    {
    case ChooseStart:
      v.setIsStart(true);
      graph.display();
      this.state = State.ChooseDestination;
      displayText = "choose a destination";      
      redrawBoard();
      break;
    case ChooseDestination:
      v.setIsDestination(true);      
      graph.display();
      this.state = State.ShowGraph;        
      displayText = "show shortest path";
      redrawBoard();

      DijkstraAlgorithm algorithm = new DijkstraAlgorithm();
      shortestPath = algorithm.getShortestPath(this.graph);

      if (this.state == State.ShowGraph)
      {            
        for (Vertex vertex : shortestPath)
        {      
          vertex.setColor(color(0, 255, 0));
          println("id: " + vertex.getId());
        }
      }           
      graph.display();
      break;              
    }
  }
}

private void redrawBoard()
{
  clear();
  background(255);  
  graph.display();
  text(displayText, 30, 30);
}

void draw()
{
}

void keyPressed()
{
  if (keyCode == 'R') {     
    graph = new Graph(COUNT_VERTICES, COUNT_EDGES);
    state = State.ChooseStart;
    graph.display();
    this.state = State.ChooseStart;
    redrawBoard();
  }
}

public enum ShortestPathAlgorithm
{
  DIJKSTRA
}

public enum State
{
  ChooseStart, 
    ChooseDestination, 
    ShowGraph
}
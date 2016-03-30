public static final int WINDOW_SIZE = 500;

private static final ShortestPathAlgorithm algorithm = ShortestPathAlgorithm.DIJKSTRA;
private Graph graph;
private static final int COUNT_EDGES = 10;
private static final int COUNT_VERTICES = 10;
private State state;
private String displayText;

void setup()
{
  size(500, 500, P3D);  
  fill(255, 255, 0);
  //Graph graph = new Graph(COUNT_VERTICES, COUNT_EDGES);
  graph = new Graph(COUNT_VERTICES, COUNT_EDGES);
  graph.display();
  this.state = State.ChooseStart;
  displayText = "choose a start";  
}

void mousePressed()
{
  Vertex v = graph.getCollidingVertex(mouseX, mouseY);
  if(v != null)
  {
    switch(this.state)
    {
      case ChooseStart:
        v.setIsStart(true);
        graph.display();
        this.state = State.ChooseDestination;
        displayText = "choose a destination";        
        break;
      case ChooseDestination:
        v.setIsDestination(true);      
        graph.display();
        this.state = State.ShowGraph;        
        displayText = "show shortest path";
        break;      
      case ShowGraph:
        //do nothing
        break;
    }
  }  
}

void draw()
{
  delay(1000);  
  clear();
  background(255);  
  graph.display();
  text(displayText, 30, 30);
}

void keyPressed()
{
  if (keyCode == 'R') { 
    graph = new Graph(COUNT_VERTICES, COUNT_EDGES);
    graph.display();
    this.state = State.ChooseStart;
  }
}



//void draw()
//{
//  switch(algorithm)
//  {
//  case DIJKSTRA:    
//    graph.display();
//    break;
//  }
//}

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
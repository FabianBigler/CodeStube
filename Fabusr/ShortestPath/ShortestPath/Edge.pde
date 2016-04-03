public class Edge
{
  private int id;
  private Vertex source;
  private Vertex destination;  
  private int weight;      

  public Vertex getSource()
  {
    return this.source;
  }

  public Vertex getDestination()
  {
    return this.destination;
  }

  public int getWeight()
  {
    return this.weight;
  }


  public Edge(int id, Vertex v1, Vertex v2)
  {
    this.id = id;
    this.source = v1;
    this.destination = v2;
    //weight is the distance between vector1 and vector2        
    //distance = (int) sqrt((this.vertex2.getX() - this.vertex1.getX())^2+(this.vertex2.getY() - this.vertex1.getY())^2);
    //distance = (int) sqrt((this.vertex2.getX() - this.vertex1.getX())^2+(this.vertex2.getY() - this.vertex1.getY())^2);
    this.weight = (int) dist(this.source.getX(), this.source.getY(), this.destination.getX(), this.destination.getY());
    //println("id: " + this.id +  " v1: x: " + this.vertex1.getX() + " y:" + this.vertex1.getY());
    //println("v2: x: " + this.vertex2.getX() + " y:" + this.vertex2.getY());
    //println("distance:" + distance);
  }

  public void display()
  {        
    line(source.getX(), source.getY(), destination.getX(), destination.getY());    
    stroke(100);
    int textX = (int) ((destination.getX() - source.getX()) / 2);
    int textY = (int) ((destination.getY() - source.getY()) / 2);
    text("weight: " + this.weight, textX + this.source.getX(), textY + this.source.getY());
    //text("word", 10, 30)
  }
}
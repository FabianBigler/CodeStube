public class Edge
{
  private int id;
  private Vertex vertex1;
  private Vertex vertex2;  
  private int distance;      

  public Vertex getVertex1()
  {
    return this.vertex1;
  }

  public Vertex getVertex2()
  {
    return this.vertex2;
  }

  public int getDistance()
  {
    return this.distance;
  }


  public Edge(int id, Vertex v1, Vertex v2)
  {
    this.id = id;
    this.vertex1 = v1;
    this.vertex2 = v2;
    //weight is the distance between vector1 and vector2        
    //distance = (int) sqrt((this.vertex2.getX() - this.vertex1.getX())^2+(this.vertex2.getY() - this.vertex1.getY())^2);
    //distance = (int) sqrt((this.vertex2.getX() - this.vertex1.getX())^2+(this.vertex2.getY() - this.vertex1.getY())^2);
    this.distance = (int) dist(this.vertex1.getX(), this.vertex1.getY(), this.vertex2.getX(), this.vertex2.getY());
    //println("id: " + this.id +  " v1: x: " + this.vertex1.getX() + " y:" + this.vertex1.getY());
    //println("v2: x: " + this.vertex2.getX() + " y:" + this.vertex2.getY());
    //println("distance:" + distance);
  }

  public void display()
  {        
    line(vertex1.getX(), vertex1.getY(), vertex2.getX(), vertex2.getY());    
    stroke(100);
    int textX = (int) ((vertex2.getX() - vertex1.getX()) / 2);
    int textY = (int) ((vertex2.getY() - vertex1.getY()) / 2);
    text("dist: " + this.distance, textX + vertex1.getX(), textY + vertex1.getY());
    //text("word", 10, 30)
  }
}
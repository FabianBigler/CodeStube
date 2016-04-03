public class  Vertex implements Comparable<Vertex>
{
  private int id;   
  private int x, y;
  public static final int SIZE = 20;
  private color col;
  private boolean isStart;
  private boolean isDestination;  

  private int distance;  
  private Vertex previous;

  public int getX()
  {
    return this.x;
  }

  public int getY()
  {
    return this.y;
  }
  
  public int getId()
  {
    return this.id;
  }
  

  public void setDistance(int distance)
  {
    this.distance = distance;
  }

  public int getDistance()
  {
    return this.distance;
  }
  
  public void setPrevious(Vertex previous)
  {
    this.previous = previous;
  }
  
  public Vertex getPrevious()
  {
    return this.previous;
  }

  public void setColor(color col)
  {
    this.col = col;    
  }

  public Vertex(int id, int x, int y)
  {
    this.id = id;
    this.x = x;
    this.y = y;
    this.col = color(200, 200, 250);
    this.distance = 0;    
  }

  public void setIsStart(boolean isStart)
  {
    this.col = color(0, 0, 255);
    this.isStart = isStart;
  }    

  public boolean getIsStart()
  {
    return this.isStart;
  }

  public void setIsDestination(boolean isDestination)
  {
    this.col = color(255, 0, 0);
    this.isDestination = isDestination;
  }  

  public boolean getIsDestination()
  {
    return this.isDestination;
  }


  void display()
  {
    fill(this.col);
    stroke(100);    
    ellipse(this.x, this.y, Vertex.SIZE, Vertex.SIZE);
    fill(0);
    stroke(0);
    text(this.id, x -5, y+5);
  }

  @Override
    public int compareTo(Vertex other) {
    return Integer.compare(this.distance, other.getDistance());
  }
}
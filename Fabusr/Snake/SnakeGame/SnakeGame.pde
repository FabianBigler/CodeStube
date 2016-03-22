import java.util.Vector;

private Game game;
private final int offset = 20;
private final int windowSize = 450;

void setup()
{          
  //can't assign windowSize directly? why not?! ;(
  size(500, 500);
  fill(100,100,100);
  rect(offset,offset,windowSize,windowSize);    
  game = new Game(500);
}

void draw()
{
  delay(100);
  clear();  
  //if(game.getSpeed() %10 == 0){    
    game.run();  
  //}  
}

void keyPressed()
{
  MoveDirection moveDirection = null;
  if(keyCode == UP) { moveDirection = MoveDirection.UP;}
  if(keyCode == DOWN) {  moveDirection = MoveDirection.DOWN; }
  if(keyCode == LEFT) { moveDirection = MoveDirection.LEFT; }
  if(keyCode == RIGHT) { moveDirection = MoveDirection.RIGHT; }  
  if(keyCode == 'R') { game = new Game(500); }
  
  if(moveDirection != null)
  {
    game.setSnakeMoveDirection(moveDirection);    
  } 
}

class Game {
  boolean gameOver;
  Snake snake; 
  float speed = 100;
  int windowSize;
  
  public void setSnakeMoveDirection(MoveDirection moveDirection)
  {
    snake.setCurrentMoveDirection(moveDirection);
  }
  
  public float getSpeed()
  {
    return this.speed;
  }
  
  
  public Game(int windowSize)
  {     
    speed=speed/frameRate;    
    snake = new Snake();
    this.windowSize = windowSize;
  }
  
  public void reset()
  {
       
    //snake.Move();
  }  
  
  public void run()
  {
    if(gameOver)
    {
      String modelString = "game over";
      text("game over",windowSize / 2 + offset,windowSize / 2 + offset,40);
    } else {
      gameOver = snake.canMove();
      if(!gameOver)
      {
        snake.move();           
        snake.Draw();
      }      
    }    
  } 
}

class Snake {
  Vector<BodyPart> bodyParts;
  MoveDirection currentMoveDirection;
  private Head head;  
  
  public void setCurrentMoveDirection(MoveDirection moveDirection)
  {
    this.currentMoveDirection = moveDirection;
  }
  
  public Snake()
  {
    //has at least a head, one chunk of body and a tail
    bodyParts = new Vector<BodyPart> (); //<>//
    head = new Head(200, 130);    
    bodyParts.add(new Body(200, 140));
    bodyParts.add(new Tail(200, 150));        
    currentMoveDirection = MoveDirection.UP;    
  }    
  
  public boolean findsFood()
  {
    return true;
  }
  
  public boolean canMove()
  {
    Locatable nextMovedPosition = this.getNextHeadLocation();
    return (!collideWithWall(nextMovedPosition) && collideSelf(nextMovedPosition));    
  }
  
  private boolean collideWithWall(Locatable nextHeadPosition)
  {    
    //left border
    if(nextHeadPosition.getX() < offset)
    {
      return true;
    }    
    //right border
    if(nextHeadPosition.getX() > (windowSize + offset))
    {
      return true; 
    }    
    //top border
    if(nextHeadPosition.getY() < (offset))
    {
      return true;
    }
     //bottom Border
    if(nextHeadPosition.getY() > (windowSize + offset))
    {
      return true;
    }    
    
    return false;    
  }
  
  private boolean collideSelf(Locatable nextHeadPosition)
  {
    int nextXRangeMax = nextHeadPosition.getX() + 5;
    int nextXRangeMin = nextHeadPosition.getX() - 5;    
    int nextYRangeMax = nextHeadPosition.getY() + 5;    
    int nextYRangeMin = nextHeadPosition.getY() - 5;      
    for(BodyPart bodyPart : bodyParts)
    {
      if(bodyPart.getX() > nextXRangeMax && bodyPart.getX() > nextXRangeMin && bodyPart.getY() > nextYRangeMax && bodyPart.getY() > nextYRangeMin)
      {        
         //collided!
         return true;
      }      
    }    
    return false;
  }
  
  
  public void move()
  {
    int previousX = head.getX();
    int previousY = head.getY();
    switch(currentMoveDirection) {
      case UP:   
        head.setY(head.getY() - BodyPart.SIZE);       
        break;
      case DOWN:        
        head.setY(head.getY() + BodyPart.SIZE);        
        break;
      case LEFT:
        head.setX(head.getX() - BodyPart.SIZE);
        break;
      case RIGHT:
        head.setX(head.getX() + BodyPart.SIZE);
        break;        
    }      

    for(BodyPart bodyPart : bodyParts)
    {
       int newX = previousX;
       int newY = previousY;
       previousX = bodyPart.getX();
       previousY = bodyPart.getY();
       bodyPart.setX(newX);
       bodyPart.setY(newY);                   
    }    
  }
  
  private Locatable getNextHeadLocation()
  {
    Locatable headLocation = new Head(0,0);    
    switch(currentMoveDirection) {
      case UP:   
        headLocation.setY(head.getY() - BodyPart.SIZE);       
        break;
      case DOWN:        
        headLocation.setY(head.getY() + BodyPart.SIZE);        
        break;
      case LEFT:
        headLocation.setX(head.getX() - BodyPart.SIZE);
        break;
      case RIGHT:
        headLocation.setX(head.getX() + BodyPart.SIZE);
        break;        
    }  
    return headLocation;
  }
  
    
  public void Draw()
  {
    head.Draw();
    for(BodyPart bodyPart : bodyParts)
    {
      bodyPart.Draw();      
    }
  }
}

class Body extends BodyPart
{ 
  public Body(int x, int y)
  {
    super(x, y);
  }
  
  @Override
  public void Draw()
  {
    fill(100, 100, 100);
    super.Draw();
  }
}

class Tail extends BodyPart
{
  public Tail(int x, int y)
  {
    super(x, y);
  }
  
  @Override
  public void Draw()
  {
    fill(150, 102, 0);
    super.Draw();
  }
}

class Head extends BodyPart
{     
  public Head(int x, int y)
  {
    super(x, y);
  }
  
  @Override
  public void Draw()
  {
    fill(204, 102, 0);
    super.Draw();    
    //a head needs eyes, right?
    //fill(0, 0, 0);    
  }
}

class BodyPart implements Locatable
{
 private int x, y;
 //assuming each bodypart has the same size...awkward.
 public final static int SIZE  = 10; 
 
 public BodyPart(int x, int y)
 {
   this.x = x;
   this.y = y;   
 }
 
 public int getX()
 {
   return this.x;
 }
 
 public void setX(int x)
 {   
   this.x = x;
 } 
 
 public int getY()
 {
   return this.y;
 }
 
 public void setY(int y)
 {
   this.y = y;
 }
 
 public void Draw()
 {
   rect(this.getX(), this.getY(),BodyPart.SIZE, BodyPart.SIZE);
 }
}

public interface Locatable
{
  void setX(int x);
  int getX();
  void setY(int y);
  int getY();  
}

public class Food implements Locatable
{
 private int x, y; 
 public final static int SIZE  = 10; 
 
 public int getX()
 {
   return this.x;
 }
 
 public void setX(int x)
 {   
   this.x = x;
 } 
 
 public int getY()
 {
   return this.y;
 }
 
 public void setY(int y)
 {
   this.y = y;
 }
}


public enum MoveDirection {
    UP, DOWN, LEFT, RIGHT  
}
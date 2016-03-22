import java.util.Vector;

private Game game;
private final int OFFSET = 30;
private final int WINDOW_SIZE = 240;
private final int GAME_LOOP_DELAY = 100; 


void setup()
{          
  //can't assign windowSize directly? why not?! ;(
  size(300, 300, P3D);
  fill(100,100,100);
  rect(OFFSET,OFFSET,WINDOW_SIZE,WINDOW_SIZE);    
  game = new Game();
}

void draw()
{
  if(!game.getPaused())
  {
    delay(GAME_LOOP_DELAY);
    clear();  
    fill(100,100,100);
    rect(OFFSET,OFFSET,WINDOW_SIZE,WINDOW_SIZE);    
    game.run();        
  }    
}

void keyPressed()
{
  MoveDirection moveDirection = null;
  if(keyCode == UP) { moveDirection = MoveDirection.UP;}
  if(keyCode == DOWN) {  moveDirection = MoveDirection.DOWN; }
  if(keyCode == LEFT) { moveDirection = MoveDirection.LEFT; }
  if(keyCode == RIGHT) { moveDirection = MoveDirection.RIGHT; }  
  if(keyCode == 'R') { game = new Game(); }
  if(keyCode == 'P') { game.togglePause();; }
  
  if(moveDirection != null)
  {
    game.setSnakeMoveDirection(moveDirection);    
  } 
}

public class Game {
  boolean gameOver;
  Snake snake; 
  Food food;
  Peasant peasant;
  //int windowSize;
  int score;
  boolean paused;
  
  public boolean getPaused()
  {
    return this.paused;
  }
  
       
  public Game()
  {     
    this.snake = new Snake();
    this.peasant = new Peasant();
    this.food = peasant.growNewFood(snake);                  
    this.score = 0;
    this.paused = false;
  }
  
  public void run()
  {
    if(this.paused) return;
    if(this.gameOver)
    {      
      textAlign(CENTER, CENTER);
      fill(255);
      text("game over. retry with R",WINDOW_SIZE / 2 + OFFSET,WINDOW_SIZE / 2 + OFFSET);
      
    } else {
      stroke(0);
      
      //some nice point grid?
      for(int y = OFFSET; y < WINDOW_SIZE + OFFSET; y+= GameObject.SIZE)
      {
        for(int x = OFFSET; x < WINDOW_SIZE + OFFSET; x+= GameObject.SIZE)
        { 
          fill(0, 255, 0);
          point(x, y);         
        }
      }  
      
      this.gameOver = !this.snake.canMove();
      if(!this.gameOver)
      {
        text("score: " + this.score, WINDOW_SIZE - OFFSET, OFFSET / 2); 
        this.snake.move();           
        if (this.snake.eatsFood(food))
        {
          this.score += Food.VALUE;
          this.food = peasant.growNewFood(snake);
        }
        this.snake.Draw();
        this.food.Draw();
      }      
    }    
  } 
  
  public void setSnakeMoveDirection(MoveDirection moveDirection)
  {
    this.snake.setCurrentMoveDirection(moveDirection);
  }
  
  public void togglePause()
  {
    this.paused = !this.paused;
  }
}

class Snake {
  Vector<GameObject> bodyParts;
  MoveDirection currentMoveDirection;
  private Head head;  
  
  public Snake()
  {
    //has at least a head, one chunk of body and a tail
    this.bodyParts = new Vector<GameObject> ();
    this.head = new Head(250, 250);    
    this.bodyParts.add(new Body(200, head.getY() + GameObject.SIZE));
    this.bodyParts.add(new Tail(200, head.getY() + (GameObject.SIZE * 2)));        
    this.currentMoveDirection = MoveDirection.UP;    
  }    
  
  public Vector<GameObject> getBodyParts()
  {
    return this.bodyParts;
  }
  
  public void setCurrentMoveDirection(MoveDirection newMoveDirection)
  {
    if (!checkOppositeDirection(this.currentMoveDirection, newMoveDirection))
    {
      this.currentMoveDirection = newMoveDirection;
    }        
  }
  
  public boolean eatsFood(Food foodToEat)
  {
    if (objectsCollided(head, foodToEat))
    {
      //the food becomes part of the body...yuk!
      this.bodyParts.add(0, foodToEat);      
      return true;
    }
    return false;
  }  
  
  public boolean canMove()
  {
    Locatable nextMovedPosition = this.getNextHeadLocation();
    return (!collideWithWall(nextMovedPosition) && !collideSelf(nextMovedPosition));    
  }
  
  private boolean checkOppositeDirection(MoveDirection oldMoveDirection, MoveDirection newMoveDirection)
  {    
    return ((oldMoveDirection == MoveDirection.UP && newMoveDirection == MoveDirection.DOWN) ||
        (oldMoveDirection == MoveDirection.DOWN && newMoveDirection == MoveDirection.UP) ||
        (oldMoveDirection == MoveDirection.LEFT && newMoveDirection == MoveDirection.RIGHT) ||
        (oldMoveDirection == MoveDirection.RIGHT && newMoveDirection == MoveDirection.LEFT));  
  }     //<>//
  
  private boolean collideWithWall(Locatable nextHeadPosition)
  {    
    //left border
    if(nextHeadPosition.getX() < OFFSET)
    {
      return true;
    }    
    //right border
    if(nextHeadPosition.getX() >= (WINDOW_SIZE + OFFSET))
    {
      return true; 
    }    
    //top border
    if(nextHeadPosition.getY() < (OFFSET))
    {
      return true;
    }
     //bottom Border
    if(nextHeadPosition.getY() >= (WINDOW_SIZE + OFFSET))
    {
      return true;
    }    
    
    return false;    
  }

  
  private boolean collideSelf(Locatable nextHeadPosition)
  {      
    for(GameObject bodyPart : bodyParts)
    {
      if(objectsCollided(nextHeadPosition, bodyPart))
      {
        return true;
      }      
    }    
    return false;
  }
  
  public boolean collides(Locatable other)
  {
    return objectsCollided(this.head, other);
  }
  
  private boolean objectsCollided(Locatable object1, Locatable object2)
  {
    int nextXRangeMax = object1.getX() + (GameObject.SIZE / 2);
    int nextXRangeMin = object1.getX() - (GameObject.SIZE / 2);    
    int nextYRangeMax = object1.getY() + (GameObject.SIZE / 2);    
    int nextYRangeMin = object1.getY() - (GameObject.SIZE / 2);    
     if(object2.getX() < nextXRangeMax && 
       object2.getX() > nextXRangeMin && 
       object2.getY() < nextYRangeMax && 
       object2.getY() > nextYRangeMin)
    {        
       //collided!
       return true;
    }      
    return false;    
  }
  
  
  public void move()
  {
    int previousX = head.getX();
    int previousY = head.getY();    
    
    Locatable nextHeadPosition = this.getNextHeadLocation();
    head.setY(nextHeadPosition.getY());
    head.setX(nextHeadPosition.getX());

    for(GameObject bodyPart : bodyParts)
    {
       int newX = previousX;
       int newY = previousY;
       previousX = bodyPart.getX();
       previousY = bodyPart.getY();
       bodyPart.setX(newX);
       bodyPart.setY(newY);                   
    }    
    
      switch(currentMoveDirection) {
      case UP:           
        head.setHeadDirection(HeadDirection.VERTICAL);       
        break;
      case DOWN:        
        head.setHeadDirection(HeadDirection.VERTICAL);
        break;
      case LEFT:
        head.setHeadDirection(HeadDirection.HORIZONTAL);
        break;
      case RIGHT:
        head.setHeadDirection(HeadDirection.HORIZONTAL);
        break;        
      }      
  }
  
  private Locatable getNextHeadLocation()
  {
    Locatable headLocation = new Head(head.getX(),head.getY());    
    switch(currentMoveDirection) {
      case UP:   
        headLocation.setY(head.getY() - GameObject.SIZE);              
        break;
      case DOWN:        
        headLocation.setY(head.getY() + GameObject.SIZE);
        break;
      case LEFT:
        headLocation.setX(head.getX() - GameObject.SIZE);
        break;
      case RIGHT:
        headLocation.setX(head.getX() + GameObject.SIZE);
        break;        
    }  
    return headLocation;
  }
  
    
  public void Draw()
  {
    head.Draw();
    for(GameObject bodyPart : bodyParts)
    {      
      bodyPart.Draw();
      fill(255, 255, 255);
      point(bodyPart.getX(), bodyPart.getY());
    }
  }
}

class Body extends GameObject
{ 
  public Body(int x, int y)
  {
    super(x, y);
  }
  
  @Override
  public void Draw()
  {
    fill(100, 0, 100);
    super.Draw();
  }
}

class Tail extends GameObject
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

class Head extends GameObject
{   
  private HeadDirection headDirection;
  private final static int EYE_SIZE = 2;
  
  public Head(int x, int y)
  {    
    super(x, y);
    headDirection = HeadDirection.VERTICAL;
  }
  
  public void setHeadDirection(HeadDirection headDirection)
  {
    this.headDirection = headDirection;
  }
  
  @Override
  public void Draw()
  {
    fill(204, 102, 0);
    super.Draw();        
    
    switch(this.headDirection)
    {
      //a head needs eyes, right?
      case HORIZONTAL:
        fill(0);
        rect(this.getX() + GameObject.SIZE / 3, this.getY() + GameObject.SIZE / 3, EYE_SIZE, EYE_SIZE);
        rect(this.getX() + GameObject.SIZE  / 3, this.getY() + GameObject.SIZE * 2 / 3, EYE_SIZE, EYE_SIZE);
        break;        
      case VERTICAL:
        fill(0);
        rect(this.getX() + GameObject.SIZE / 3, this.getY() + GameObject.SIZE / 2, EYE_SIZE, EYE_SIZE);
        rect(this.getX() + GameObject.SIZE * 2 / 3, this.getY() + GameObject.SIZE / 2, EYE_SIZE, EYE_SIZE);
        break;
   }     
  }   
}

class GameObject implements Locatable
{
 private int x, y; 
 public final static int SIZE  = 10; 
 
 public GameObject(int x, int y)
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
   rect(this.getX(), this.getY(),GameObject.SIZE, GameObject.SIZE);
 }
}

public interface Locatable
{
  void setX(int x);
  int getX();
  void setY(int y);
  int getY();  
}

public class Food extends GameObject
{
  public static final int VALUE = 9;  
  color col;
  
  public Food(int x, int y, color col)
  {
    super(x, y);    
    this.col = col;
  }
     
  
  @Override
  public void Draw()
  {
    fill(this.col);      
    super.Draw();               
  }
}

public class Peasant
{
  public Food growNewFood(Snake snake)
  {    
    return findRandomPlaceForFood(snake);        
  }
  
  private Food findRandomPlaceForFood(Snake snake)
  {       
    //this function gets really slow once the snake has filled the board...
    boolean foodCollidesWithSnake = true;
    Food food = null;
    while(foodCollidesWithSnake){      
      int randomX = (int)((floor(random(OFFSET, WINDOW_SIZE + OFFSET) / GameObject.SIZE)) * GameObject.SIZE);
      int randomY = (int)(floor((random(OFFSET, WINDOW_SIZE + OFFSET) / GameObject.SIZE)) * GameObject.SIZE);
      
      food = new Food(randomX, randomY, color(random(255), random(255), random(255)));      
      foodCollidesWithSnake = snake.collides(food);
    }    
    return food;
  }    
}


public enum MoveDirection {
    UP, DOWN, LEFT, RIGHT  
}

public enum HeadDirection {
    HORIZONTAL, VERTICAL
}
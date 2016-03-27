final int MAX_COLS = 20;
final int MAX_ROWS = 20;
final int FIELD_WIDTH = 40;

int [] snakeX;
int [] snakeY;
int snakeLen = 1;

int headX = 0;
int headY = 0;
int speedX = 1;
int speedY = 0;
int direction = 0;

int foodX = 0;
int foodY = 0;

int gameSpeed = 15;
boolean gameOver = false;


void setup()
{    
  snakeX = new int[100];
  snakeX[0] = 2;
  snakeX[1] = 1;
  snakeX[2] = 0;

  snakeY = new int[100];
  snakeY[0] = 0;
  snakeY[1] = 0;
  snakeY[2] = 0;

  size(800, 800);

  headX = snakeX[0];
  headY = snakeY[0];

  setFoodLocation();

  //noStroke();
}







void draw()
{
  if (!gameOver && frameCount % gameSpeed == 0)
  {
    handleKeyboardInput();
    checkBitItself();
    checkBorderOverflow();

    if (isHeadOnFood())
    {
      snakeLen += 1;
      setFoodLocation();
    }

    moveSnake();

    drawGameBoard();
    increaseGameSpeed();
  }
}


void drawGameBoard()
{
  int fieldX = 0;
  int fieldY = 0;

  for (int y = 0; y < MAX_ROWS; y++)
  {
    for (int x = 0; x < MAX_COLS; x++)
    {
      if (isSnake(x, y))
      {
        fill(0);
      } else if (x == foodX && y == foodY)
      {
        fill(255, 0, 0);
      } else
      {
        fill(255);
      }
      rect(fieldX, fieldY, FIELD_WIDTH, FIELD_WIDTH);
      fieldX += FIELD_WIDTH;
    }

    fieldX = 0;
    fieldY += FIELD_WIDTH;
  }
}


void moveSnake()
{
  for (int i = snakeLen - 1; i > 0; i--)
  {
    snakeX[i] = snakeX[i-1];
    snakeY[i] = snakeY[i-1];
  }
  snakeX[0] = headX;
  snakeY[0] = headY;
}


boolean isSnake(int x, int y) {
  for (int i = 0; i < snakeLen; i++)
  {
    if (snakeX[i] == x && snakeY[i] == y)
    {
      return true;
    }
  }
  return false;
}


void checkBorderOverflow()
{
  if (headX == MAX_COLS) 
  {
    headX = 0;
  } else if (headX == -1) 
  {
    headX = MAX_COLS - 1;
  } else if (headY == MAX_ROWS) 
  {
    headY = 0;
  } else if (headY == -1) 
  {
    headY = MAX_ROWS;
  }
}


void checkBitItself()
{
  for (int i = 0; i < snakeLen; i++)
  {
    if (headX == snakeX[i] && headY == snakeY[i])
    {
      println("GameOver!");
      gameOver = true;
      break;
    }
  }
}


boolean isHeadOnFood()
{
  return (headX == foodX && headY == foodY);
}


void setFoodLocation()
{
  do
  {
    foodX = (int) random(MAX_COLS);
    foodY = (int) random(MAX_ROWS);
  } 
  while (isSnake(foodX, foodY));
}


void increaseGameSpeed()
{  
  switch(snakeLen)
  {
  case 3:
    gameSpeed = 13;
    break;
  case 6:
    gameSpeed = 11;
    break;
  case 9:
    gameSpeed = 9;
    break;
  case 12:
    gameSpeed = 8;
    break;
  case 15:
    gameSpeed = 7;
    break;
  case 18:
    gameSpeed = 6;
    break;
  case 21:
    gameSpeed = 5;
    break;
  case 24:
    gameSpeed = 4;
    break;
  }
}


void handleKeyboardInput() {
  switch(keyCode)
  {
  case UP:
    if (speedY <= 0)
    {
      speedY = -1;
      speedX = 0;
    }
    break;

  case DOWN:
    if (speedY >= 0)
    {
      speedY = 1;
      speedX = 0;
    }
    break;

  case LEFT:
    if (speedX <= 0)
    {
      speedY = 0;
      speedX = -1;
    }
    break;

  case RIGHT:
    if (speedX >= 0)
    {
      speedY = 0;
      speedX = 1;
    }
    break;
  }

  headX += speedX;
  headY += speedY;
}

void setDirection()
{
  switch (direction)
  {
  case 0:
  }
}

void setSnakeDirection()
{
  boolean xMatched = false;
}
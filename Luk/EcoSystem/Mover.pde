

public class Mover extends Element
{

  private int grayValue;

  //Initialisierung
  public Mover()
  {
    super();

    speedX = random(3);
    speedY = random(3);
    this.radius = (int)random(10, 25);
    this.grayValue = (int)random(0, 255);
  }


  public void zeichnen()
  {
    fill(this.grayValue);
    super.zeichnen();
  }


  public boolean isOnMouse()
  {
    return (dist((float)mouseX, (float)mouseY, this.posX, this.posY) <= this.radius);
  }
}
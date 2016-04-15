
public class Eater extends Element
{

  public Eater()
  {
    super();

    this.speedX = random(3);
    this.speedY = random(3);
    this.radius = 40;
  }

  public void zeichnen()
  {
    fill(255, 255, 0);
    super.zeichnen();
  }
  
  public void fressen(ArrayList<Mover> movers)
  {
    for(Mover m : movers)
    {
      if (m.IsAlive && dist(this.posX, this.posY, m.posX, m.posY) < this.radius + m.radius)
      {
        this.radius += 5;
        m.IsAlive = false;
        break;
      }
    }
  }
}
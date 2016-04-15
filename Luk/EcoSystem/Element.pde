public abstract class Element
{
  //Attribute  
  public float posX, posY;
  public float speedX, speedY;
  public float radius;
  public boolean IsAlive;

  public Element()
  {     
    this.posX = (int)random(width);
    this.posY = (int)random(height);
    this.IsAlive = true;
  }


  public void bewegen()
  {
    this.posX += this.speedX;
    this.posY += this.speedY;

    rebound();
  }


  public void zeichnen()
  {
    ellipse((int)this.posX, (int)this.posY, this.radius * 2, this.radius * 2);
  }


  public void rebound()
  {
    if (this.posX <= this.radius)             this.speedX = Math.abs(this.speedX);
    if (this.posX >= width - this.radius)     this.speedX = - Math.abs(this.speedX);
    if (this.posY <= this.radius)             this.speedY = Math.abs(this.speedY); 
    if (this.posY >= height - this.radius)    this.speedY = - Math.abs(this.speedY);
  }
}
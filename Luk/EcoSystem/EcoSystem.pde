ArrayList<Mover> meineMovers = new ArrayList<Mover>();
ArrayList<Eater> meineEaters = new ArrayList<Eater>();

void setup()
{
  background(255);
  fullScreen();

  for (int i = 0; i < 100; i++)
  {
    meineMovers.add(new Mover());
  }

  for (int i = 0; i < 3; i++)
  {
    meineEaters.add(new Eater());
  }
}


void draw()
{
  background(255);

  for (Mover m : meineMovers)
  {
    if (m.IsAlive)
    {
      m.bewegen();
      m.zeichnen();
    }
  }

  for (Eater e : meineEaters)
  {
    e.bewegen();
    e.zeichnen();
    e.fressen(meineMovers);
  }
}
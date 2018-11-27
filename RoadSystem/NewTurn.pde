class NewTurn
{
  int x;
  int y;
  int wid;
  int hei;
  PImage image;
  boolean active;
  NewTurn(int X, int Y, int w, int h, PImage img)
  {
    x = X;
    y = Y;
    wid = w;
    hei = h;
    image = img;
    active = false;
  }
  TileSelect[] checkForInput()
  {
    if(mouseX > x && mouseX < x + wid && mouseY > y && mouseY < y + hei)
    {
      active = false;
      score = 0;
      return GenerateNewTiles();
    }
    else return null;
  }
  TileSelect[] GenerateNewTiles()
  {
    TileSelect[] tileSelect = new TileSelect[4];
    for(int i = 0; i < 4; i++)
    {
      int randy = (int)random(1,9);
      int north = 0;
      int west = 0;
      int east = 0;
      int south = 0;
      if(randy == 1)
      {
        north = 1;
        south = 1;
        west = 0;
        east = 0;
      }
      if(randy == 2)
      {
        north = 2;
        south = 2;
        west = 0;
        east = 0;
      }
      if(randy == 3)
      {
        north = 1;
        south = 2;
        west = 0;
        east = 0;
      }
      if(randy == 4)
      {
        north = 0;
        south = 2;
        west = 0;
        east = 1;
      }
      if(randy == 5)
      {
        north = 0;
        south = 2;
        west = 0;
        east = 2;
      }
      if(randy == 6)
      {
        north = 2;
        south = 2;
        west = 0;
        east = 2;
      }
      if(randy == 7)
      {
        north = 1;
        south = 1;
        west = 0;
        east = 1;
      }
      if(randy == 8)
      {
        north = 0;
        south = 1;
        west = 0;
        east = 1;
      }
      tileSelect[i] = new TileSelect(reverseImg, rotateImg, images[randy], 50, 50 + 70*i, 192, 64, west, east, north, south, i);
    }
    return tileSelect;
  }
  void show()
  {
     image(image, x, y);
  }
}

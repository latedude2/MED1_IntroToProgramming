class Tile
{
  int x;
  int y;
  int wid;
  int hei;
  int I;
  int J;
  PImage tile;
  boolean justPlaced;
  public boolean active;
  int selectedNr;
  int west;    //0 - nothing, 1 - traintrack, 2 - road
  int east;
  int north;
  int south;
  Tile(PImage ti, int X, int Y, int W, int H, int w, int e, int n, int s, int Ix, int Jy)
  {
    tile = ti;
    justPlaced = false;
    active = true;
    x = X;
    y = Y;
    wid = W;
    hei = H;
    west = w;
    east = e;
    north = n;
    south = s;  
    I = Ix;
    J = Jy;
  }
  void show()
  {
     if(justPlaced)
     {
         tint(200,200,255);
     }
     else if(mouseX > x && mouseX < x + wid && mouseY > y && mouseY < y + hei)
     {
       tint(200,200,200);
     }
     image(tile, x, y);
     tint(255,255,255);
  }
  void checkForInput(PImage empty)
  {
    if(mouseX > x && mouseX < x + wid && mouseY > y && mouseY < y + hei)
    {
        if(justPlaced)
        {
          pencil.play();
          justPlaced = false;
          tile = empty;
          west = 0;
          east = 0;
          north = 0;
          south = 0; 
          
          tileSelect[selectedNr].placed = false;
          Selected = tileSelect[selectedNr];
        }
        else if(!Selected.placed && checkIfTileFits())
        {
          pencil.play();
          justPlaced = true;
          tile = Selected.tile;
          west = Selected.west;
          east = Selected.east;
          north = Selected.north;
          south = Selected.south; 
          Selected.placed = true;
          selectedNr = Selected.selectedNr;
          println("Placed tile: N: " + north + " S: " + south + " E:" + east + " W:" + west);
        }
    }
  }
  boolean checkIfTileFits()
  {
    if(checkIfWestFits() && checkIfEastFits() && checkIfSouthFits() && checkIfNorthFits())
    {
      return true;
    }
    println("Tile does not fit.");
    return false;
  }
  boolean checkIfWestFits()
  {
    if(I == 0)
      return true;
    if(Selected.west == tiles[I - 1][J].east || Selected.west == 0 || tiles[I - 1][J].east == 0)
    {
      return true;
    }
    else return false;
  }
  boolean checkIfEastFits()
  {
    if(I == mapSize - 1)
      return true;
    if(Selected.east == tiles[I + 1][J].west || Selected.east == 0 || tiles[I + 1][J].west == 0)
    {
      return true;
    }
    else return false;
  }
  boolean checkIfNorthFits()
  {
    if(J == 0)
      return true;
    if(Selected.north == tiles[I][J - 1].south || Selected.north == 0 || tiles[I][J - 1].south == 0)
    {
      return true;
    }
    else return false;
  }
  boolean checkIfSouthFits()
  {
    if(J == mapSize - 1)
      return true;
    if(Selected.south == tiles[I][J + 1].north || Selected.south == 0 || tiles[I][J + 1].north == 0)
    {
      return true;
    }
    else return false;
  }
}

class Tile
{
  int x;  //x coordinate of the tile
  int y;  //y coordinate of the tile
  int wid;  //the width of the tile
  int hei;  //the height of the tile
  int I;    //X coordinate in the map
  int J;    //Y coorinate in the map
  PImage tile;    //Image of the tile
  boolean justPlaced;    //Has this tile been placed this turn
  public boolean active; //Is this tile available for recursive search for path
  int selectedNr;        //Which tile select is selected
  int west;    //0 - nothing, 1 - traintrack, 2 - road
  int east;    //0 - nothing, 1 - traintrack, 2 - road
  int north;   //0 - nothing, 1 - traintrack, 2 - road
  int south;   //0 - nothing, 1 - traintrack, 2 - road
  
  //Constructor
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
  
  //Draw the tile on the screen
  void show()
  {
     if(justPlaced)  //if it was placed this turn
     {
         tint(200,200,255);  //tint it blue
     }
     else if(mouseX > x && mouseX < x + wid && mouseY > y && mouseY < y + hei)    //if mouse is hovering on the tile
     {
       tint(200,200,200);  //Tint it gray
     }
     image(tile, x, y);    //show it on screen
     tint(255,255,255);    //return tint back to normal
  }
  //Check if this tile is being interacted with
  //empty - an image of an empty tile, to replace with if tile is "removed" from the board
  void checkForInput(PImage empty)    
  {
    if(mouseX > x && mouseX < x + wid && mouseY > y && mouseY < y + hei)      //if mouse is hovering on the tile
    {
        if(justPlaced)    //if it was placed this turn
        {
          pencil.play();  //play pencil draw sound
          justPlaced = false;
          tile = empty;  //set tile to show it's empty
          west = 0;
          east = 0;
          north = 0;
          south = 0; 
          
          tileSelect[selectedNr].placed = false;    //set the tile select so it hasn't been placed
          Selected = tileSelect[selectedNr];        //Reset the selected tile to the one that was just removed
        }
        else if(!Selected.placed && checkIfTileFits())    //if the selected tile hasn't been placed yet and the tile fits in this position(road/track wise)
        {
          pencil.play();      //play pencil draw sound
          justPlaced = true;  
          tile = Selected.tile;  //copy tile data from selected tile
          west = Selected.west;
          east = Selected.east;
          north = Selected.north;
          south = Selected.south; 
          Selected.placed = true;
          selectedNr = Selected.selectedNr;
          //println("Placed tile: N: " + north + " S: " + south + " E:" + east + " W:" + west);
        }
    }
  }
  //Returns true if the tile fits
  boolean checkIfTileFits()
  {
    if(checkIfWestFits() && checkIfEastFits() && checkIfSouthFits() && checkIfNorthFits())
    {
      return true;
    }
    println("Tile does not fit.");
    return false;
  }
  //Returns true if west side of the tile fits
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
  //Returns true if east side of the tile fits
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
  //Returns true if north side of the tile fits
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
  //Returns true if south side of the tile fits
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

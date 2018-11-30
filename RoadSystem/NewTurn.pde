class NewTurn
{
  int x;  //x coordinate of the button
  int y;  //y coordinate of the button
  int wid;  //the width of the button
  int hei;  //the height of the button
  PImage image;    
  
  //Constructor
  NewTurn(int X, int Y, int w, int h, PImage img)
  {
    x = X;
    y = Y;
    wid = w;
    hei = h;
    image = img;
  }
  //Check if this button is being pressed
  //Returns a new array of tiles for selection by the user
  TileSelect[] checkForInput()
  {
    //If mouse is within the confines of the button
    if(mouseX > x && mouseX < x + wid && mouseY > y && mouseY < y + hei)
    {
      //Reset the score and generate the new tiles
      score = 0;
      return GenerateNewTiles();
    }
    else return null;
  }
  //Generates new tiles for the tile selection
  TileSelect[] GenerateNewTiles()
  {
    //Create a new list of tiles
    TileSelect[] tileSelect = new TileSelect[selectionAmount];
    for(int i = 0; i < selectionAmount; i++)
    {
      //Which tile to choose
      int randy = (int)random(1,tileAmount);
      //New tile sides
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
      //Create new tile
      int tileSelectX = 50;
      int tileSelectYstart = 50;
      int spaceBetweenTiles = 70;
      int tileSelectWidth = 192;
      int tileSelectHeight = 64;
      tileSelect[i] = new TileSelect(reverseImg, rotateImg, images[randy], tileSelectX, tileSelectYstart + spaceBetweenTiles*i, tileSelectWidth, tileSelectHeight, west, east, north, south, i);
    }
    return tileSelect;
  }
  //Show the button on the screen
  void show()
  {
    if(mouseX > x && mouseX < x + wid && mouseY > y && mouseY < y + hei)
     {
       tint(200,200,200);
     }
     image(image, x, y);
     tint(255,255,255);
  }
}

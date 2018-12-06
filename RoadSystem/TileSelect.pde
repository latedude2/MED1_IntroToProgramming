class TileSelect
{
  int x;  //x coordinate of the tile selection tab
  int y;  //y coordinate of the tile selection tab
  int wid;  //the width of the tile selection tab
  int hei;  //the height of the tile selection tab
  PImage reverse;    //Image showing "reversion" icon
  PImage rotate;     //Image showing "rotation" icon
  PImage tile;       //Image showing the selectable tile
  int selectedNr;    //Number of tile selection tab
  boolean placed = false;    //Has this tile been placed
  boolean selected = false;  //Is this tile selected
  int west;    //0 - nothing, 1 - traintrack, 2 - road
  int east;    //0 - nothing, 1 - traintrack, 2 - road
  int north;   //0 - nothing, 1 - traintrack, 2 - road
  int south;   //0 - nothing, 1 - traintrack, 2 - road
  
  //Constructor
  TileSelect(PImage re, PImage ro, PImage ti, int X, int Y, int W, int H, int w, int e, int n, int s, int selNr)
  {
    reverse = re;
    rotate = ro;
    tile = ti;
    x = X;
    y = Y;
    wid = W;
    hei = H;
    west = w;
    east = e;
    north = n;
    south = s;
    selectedNr = selNr;
  }
  //Check if any button of the selection tab is being pressed
  void checkForInput()
  {
    if(mouseX > x + wid/3*2 && mouseX < x + wid && mouseY > y && mouseY < y + hei)
    {
       Reverse();   //Reverse the tile vertically
    }
    if(mouseX > x && mouseX < x + wid/3 && mouseY > y && mouseY < y + hei)
    {
       Rotate();    //Rotate the tile
    }
    if(mouseX > x + wid/3 && mouseX < x + wid/3*2 && mouseY > y && mouseY < y + hei)
    {
       Select();    //Select the tile
    }
  }
  //Select the tile for placement
  private void Select()
  {
     if(!placed)
     {
       Selected = this;
       for(int i = 0; i < 4; i++)
       {
         tileSelect[i].selected = false;
       }
       selected = true;
     }
  }
  //Rotate the tile counter-clockwise, Height and width of the tile have to be the same for this to work
  private void Rotate()
  {
    Reverse();  //Reverse it first
    PImage rotated = createImage(tile.width,tile.height,RGB);    //create a new image with the same dimensions
    for(int i = 0 ; i < rotated.width; i++)
    {               
      for(int j = 0; j < rotated.height; j++)
      {
        rotated.pixels[i*hei + j] = tile.pixels[j*hei + i];    //Copy each pixel, this is going to fun to explain during the exam
      }
    }
    tile = rotated;
    //Change the tile road/track data
    int temp = west;
    west = north;  
    north = temp;
    temp = east;
    east = south;
    south = temp;
}
  private void Reverse()
  {
  PImage flipped = createImage(tile.width,tile.height,RGB);    //create a new image with the same dimensions
  for(int x = 0 ; x < flipped.width; x++){               //loop through each column
    flipped.set(flipped.width-x-1,0,tile.get(x,0,1,tile.height));       //copy a column in reverse x order
  }
  tile = flipped;
  
  //Change the tile road/track data
  int temp = west;
  west = east;
  east = temp;
  }
  //Draw this tile selection tab
  void show()
  {
    if(selected)  //If tile is selected
    {
      tint(255, 255, 0);  //tint it yellow
    }
    else if(mouseX > x + wid/3 && mouseX < x + wid/3*2 && mouseY > y && mouseY < y + hei)  //if mouse is hovering
     {
       tint(200,200,200);    //tint grey
     }
    image(tile, x + wid/3, y);  //draw tile
    tint(255);  //return tint to normal
    
    if(mouseX > x + wid/3*2 && mouseX < x + wid && mouseY > y && mouseY < y + hei)  //if mouse is hovering
     {
       tint(200,200,200);  //tint grey
     }
    image(reverse, x + wid/3*2, y);    //draw reversion icon
    tint(255);  //return tint to normal
    
    if(mouseX > x && mouseX < x + wid/3 && mouseY > y && mouseY < y + hei)  //if mouse is hovering
     {
       tint(200,200,200);  //tint grey
     }
    image(rotate, x, y);    //draw rotation icon
    tint(255);  //return tint to normal
  }
}

class TileSelect
{
  int x;
  int y;
  int wid;
  int hei;
  PImage reverse;
  PImage rotate;
  PImage tile;
  int selectedNr;
  boolean placed = false;
  boolean selected = false;
  int west;    //0 - nothing, 1 - traintrack, 2 - road
  int east;
  int north;
  int south;
  
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
  void checkForInput()
  {
    if(mouseX > x + wid/3*2 && mouseX < x + wid && mouseY > y && mouseY < y + hei)
    {
       Reverse(); 
    }
    if(mouseX > x && mouseX < x + wid/3 && mouseY > y && mouseY < y + hei)
    {
       Rotate(); 
    }
    if(mouseX > x + wid/3 && mouseX < x + wid/3*2 && mouseY > y && mouseY < y + hei)
    {
       Select();
    }
  }
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
  private void Rotate()
  {
    Reverse();
    PImage rotated = createImage(tile.width,tile.height,RGB);//create a new image with the same dimensions
    for(int i = 0 ; i < rotated.width; i++)
    {               
      for(int j = 0; j < rotated.height; j++)
      {
        rotated.pixels[i*64 + j] = tile.pixels[j*64 + i];       //copy a column in reverse x order
      }
    }
    tile = rotated;
    int temp = west;
    west = north;
    north = temp;
    temp = east;
    east = south;
    south = temp;
}
  private void Reverse()
  {
  PImage flipped = createImage(tile.width,tile.height,RGB);//create a new image with the same dimensions
  for(int x = 0 ; x < flipped.width; x++){               //loop through each columns
  flipped.set(flipped.width-x-1,0,tile.get(x,0,1,tile.height));       //copy a column in reverse x order
  }
  tile = flipped;
  
  int temp = west;
  west = east;
  east = temp;
  }
  void show()
  {
    if(selected)
    {
      tint(255, 255, 0);
    }
    else if(mouseX > x + wid/3 && mouseX < x + wid/3*2 && mouseY > y && mouseY < y + hei)
     {
       tint(200,200,200);
     }
    image(tile, x + wid/3, y);
    tint(255);
    
    if(mouseX > x + wid/3*2 && mouseX < x + wid && mouseY > y && mouseY < y + hei)
     {
       tint(200,200,200);
     }
    image(reverse, x + wid/3*2, y);
    tint(255);
    
    if(mouseX > x && mouseX < x + wid/3 && mouseY > y && mouseY < y + hei)
     {
       tint(200,200,200);
     }
    image(rotate, x, y);    
    tint(255);
  }
}

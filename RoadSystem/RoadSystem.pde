//Sound
import processing.sound.*;      //Importing sound library
public SoundFile pencil;        

//Images
PImage[] images = new PImage[9];
PImage rotateImg;
PImage reverseImg;
PImage nextImg;
PImage background;

//Tiles
public int selectionAmount = 4;
public int tileAmount = 0;
TileSelect[] tileSelect = new TileSelect[selectionAmount];  //Declaring tile selection objects
public TileSelect Selected;    //The currently selected tile
public int mapSize = 7;        //Size of the map

//Global game variables
int turn = 1;
int score = 0;

//Declaring tiles for the whole map
public Tile[][] tiles = new Tile[mapSize][mapSize];

//Next turn button
NewTurn next;

void setup()
{
  size(800, 600);
  
  //Getting all the tile images from the data folder
  File file = new File(dataPath(""));  
  //println(file); //print data folder location
  String[] filenames = file.list();
  tileAmount = filenames.length;
  //loading other misc images
  rotateImg = loadImage("Rotate.png");
  reverseImg = loadImage("Reverse.png");
  nextImg = loadImage("Next.png");
  background = loadImage("Background.png");
  
  //loading sound file
  pencil = new SoundFile(this, "Pencil.mp3");

  //loading the tile images
  for(int i = 0; i < images.length; i++)
  {
    images[i] = loadImage(filenames[i]);
  }
  
  int mapStartX = 300;
  int mapStartY = 50;
  //placing all of the images on the screen
  for(int i = 0; i < mapSize; i++)
  {
    for(int j = 0; j < mapSize; j++)
    {
      tiles[i][j] = new Tile(images[0], mapStartX + i * images[0].width, mapStartY + j * images[0].height, images[0].width, images[0].height, 0, 0, 0, 0, i, j);
    }
  }
  
  //Placing next turn button
  int nextY = 350;
  int nextX = 80;
  int nextWidth = 130;
  int nextHeight = 50;
  next = new NewTurn(nextX, nextY, nextWidth, nextHeight, nextImg);
  //Generating new tiles for the selection
  tileSelect = next.GenerateNewTiles();
  //Selecting the first tile as the selected one
  Selected = tileSelect[0];
  tileSelect[0].selected = true;
}

void draw() {
  //Drawing background image
  int bckX = 278;
  int bckY = 28;
  image(background, bckX, bckY);
  //Drawing the tile selection
  for(int i = 0; i < selectionAmount; i++)
  {
      tileSelect[i].show();
  }
  //Drawing the map tiles
  for(int i = 0; i < mapSize; i++)
  {
    for(int j = 0; j < mapSize; j++)
    {
      tiles[i][j].show();
    }
  }
  //Drawing the next turn button
  next.show();
  
  //draw score
  rect(70, 415, 150, 45);
  textSize(32);
  fill(0, 102, 153);
  text("Score: " + score, 80, 450); 
  fill(255, 255, 255);
  
  //draw turn
  rect(70, 465, 150, 45);
  textSize(32);
  fill(0, 102, 153);
  text("Turn: " + turn, 80, 500); 
  fill(255, 255, 255);
}
void mouseClicked()
{
  //Checking if the map tiles were pressed
  for(int i = 0; i < mapSize; i++)
  {
    for(int j = 0; j < mapSize; j++)
    {
      tiles[i][j].checkForInput(images[0]);
    }
  }
  //Checking if the tile selection buttons were pressed
  for(int i = 0; i < selectionAmount; i++)
  {
    tileSelect[i].checkForInput();
  }
  //Checking if the next turn button was pressed
  if(next.checkForInput() != null)
  {
    //Incrementing the current turn
    turn++;
    //changing the tiles
    tileSelect = next.checkForInput();
    countScore();
    
    //Setting the tiles to not just placed
    for(int i = 0; i < mapSize; i++)
    {
      for(int j = 0; j < mapSize; j++)
      {
        tiles[i][j].justPlaced = false;
      }
    }
  }
}
//Counts the score
public void countScore()
{
  //println("Counting score");
  //Counting from the north and south exits
  for(int i = 1; i < mapSize; i = i + 2)
  {
    if(tiles[0][i].active)
      if(tiles[i][0].west != 0)
        score += StartCount(0, i, true);
        
    if(tiles[mapSize - 1][i].active)
      if(tiles[i][0].east != 0)
        score += StartCount(mapSize - 1, i, true);
  }
  //Counting from the east and west exits
  for(int i = 1; i < mapSize; i = i + 2)
  {
    if(tiles[i][0].active)
      if(tiles[i][0].north != 0)
        score += StartCount(i, 0, true);
    if(tiles[i][mapSize - 1].active)
      if(tiles[i][0].south != 0)
        score += StartCount(i, mapSize - 1, true);
  }
  //Setiing all the tiles to active for score counting
  for(int i = 0; i < mapSize; i++)
  {
    for(int j = 0; j < mapSize; j++)
    {
      tiles[i][j].active = true;
    }
  }
}
//Start counting from certain tile. Function used recursively
//x - x coordinate of tile
//y - y coordinate of tile
//start - true if this is a tile from which the counting starts(near an exit)
int StartCount(int x, int y, boolean start)
{
  int score = 0;
  //Setting active to false since the tile was already checked
  tiles[x][y].active = false;
  //Adding the score from all directions
  score += countEast(x, y, start);
  score += countWest(x, y, start);
  score += countNorth(x, y, start);
  score += countSouth(x, y, start);
  //println("At: " + x + ";" + y);
  return score;
}
//Counts the points that come from the east side of the tile
//x - x coordinate of tile
//y - y coordinate of tile
//start - true if this is a tile from which the counting starts(near an exit)
int countEast(int x, int y, boolean start)
{
  for(int i = 1; i < mapSize; i = i + 2)  //for each eastern exit
  {
    if(x == mapSize - 1 && y == i)  //if the tile is near the exit
    {
      if(tiles[x][y].east != 0)  //if the tile's east part is not empty
      {
        //println("Point from east");  
        if(!start) return 1;  //if it is not a starting tile add a point
        else return 0;  //else, no points
      }
    }
  }
  if(x < mapSize - 1 && tiles[x + 1][y].active && tiles[x][y].east != 0 && tiles[x][y].east == tiles[x + 1][y].west)
  {   //if the tile has a tile to the east and it hasn't been reached before and this tile has a connection to the east and the connection matches the connection of the tile to the east
    //println("Going east");
    //count points from the tile to the east
    return StartCount(x + 1, y, false);
  }
  else 
  {
    //End of the road, stop counting
    //println("stopping at " + x +";" + y );
    return 0;
  }
}
//Counts the points that come from the west side of the tile
//x - x coordinate of tile
//y - y coordinate of tile
//start - true if this is a tile from which the counting starts(near an exit)
int countWest(int x, int y, boolean start)
{
  for(int i = 1; i < mapSize; i = i + 2) //for each western exit
  {
    if(x == 0 && y == i)  //if the tile is near the exit
    {
      if(tiles[x][y].west != 0)//if the tile's west part is not empty
      {
        //println("Point from west");
        if(!start) return 1;  //if it is not a starting tile add a point
        else return 0;  //else, no points
      }
    }
  }
  if(x > 0 && tiles[x - 1][y].active && tiles[x][y].west != 0 && tiles[x - 1][y].east == tiles[x][y].west)
  {//if the tile has a tile to the west and it hasn't been reached before and this tile has a connection to the west and the connection matches the connection of the tile to the west
    //println("Going west");
    //count points from the tile to the west
    return StartCount(x - 1, y, false);
  }
  else 
  {
    //End of the road, stop counting
    //println("stopping at " + x +";" + y );
    return 0;
  }
}
//Counts the points that come from the north side of the tile
//x - x coordinate of tile
//y - y coordinate of tile
//start - true if this is a tile from which the counting starts(near an exit)

int countNorth(int x, int y, boolean start)
{
  for(int i = 1; i < mapSize; i = i + 2) //for each northern exit
  {
    if(x == i && y == 0)  //if the tile is near the exit
    {
      if(tiles[x][y].north != 0)  //if the tile's north part is not empty
      {
        //println("Point from north");
        if(!start) return 1;  //if it is not a starting tile add a point
        else return 0;  //else, no points
      }
    }
  }
  if(y > 0 && tiles[x][y - 1].active && tiles[x][y].north != 0 && tiles[x][y].north == tiles[x][y - 1].south)
  {//if the tile has a tile to the north and it hasn't been reached before and this tile has a connection to the north and the connection matches the connection of the tile to the north
    //println("Going north");
    //count points from the tile to the north
    return StartCount(x, y - 1, false);
  }
  else 
  {
    //End of the road, stop counting
    //println("stopping at " + x +";" + y );
    return 0;
  }
}
//Counts the points that come from the south side of the tile
//x - x coordinate of tile
//y - y coordinate of tile
//start - true if this is a tile from which the counting starts(near an exit)

int countSouth(int x, int y, boolean start)
{
  for(int i = 1; i < mapSize; i = i + 2) //for each southern exit
  {
    if(x == i && y == mapSize - 1)  //if the tile is near the exit
    {
      if(tiles[x][y].south != 0)  //if the tile's south part is not empty
      {
        //println("Point from south");
        if(!start) return 1;  //if it is not a starting tile add a point
        else return 0;  //else, no points
      }
    }
  }
  if(y < mapSize - 1 && tiles[x][y + 1].active && tiles[x][y].south != 0 && tiles[x][y].south == tiles[x][y + 1].north)
  {  //if the tile has a tile to the south and it hasn't been reached before and this tile has a connection to the south and the connection matches the connection of the tile to the south
    //println("Going south");
    //count points from the tile to the south
    return StartCount(x, y + 1, false);
  }
  else 
  {
    //End of the road, stop counting
    //println("stopping at " + x +";" + y);
    return 0;
  }
}

  

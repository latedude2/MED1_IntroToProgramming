//Sound
import processing.sound.*;
public SoundFile pencil;

//Images
PImage[] images = new PImage[9];
PImage rotateImg;
PImage reverseImg;
PImage nextImg;
PImage background;

//Tiles
TileSelect[] tileSelect = new TileSelect[4];
public TileSelect Selected;
public int mapSize = 7;
int turn = 1;
int score = 0;
public Tile[][] tiles = new Tile[mapSize][mapSize];
NewTurn next;
void setup()
{
  size(800, 600);
  File file = new File(dataPath(""));
  println(file);
  String[] filenames = file.list();
  rotateImg = loadImage("Rotate.png");
  reverseImg = loadImage("Reverse.png");
  nextImg = loadImage("Next.png");
  background = loadImage("Background.png");
  pencil = new SoundFile(this, "Pencil.mp3");

  for(int i = 0; i < images.length; i++)
  {
    images[i] = loadImage(filenames[i]);
  }
  
  for(int i = 0; i < mapSize; i++)
  {
    for(int j = 0; j < mapSize; j++)
    {
      tiles[i][j] = new Tile(images[0], 300 + i*64, 50 + j * 64, 64, 64, 0, 0, 0, 0, i, j);
    }
  }
  next = new NewTurn(80, 350, 130, 50, nextImg);
  tileSelect = next.GenerateNewTiles();
  Selected = tileSelect[0];
}

void draw() {
  image(background, 278, 28);
  for(int i = 0; i < 4; i++)
  {
      tileSelect[i].show();
  }
  for(int i = 0; i < mapSize; i++)
  {
    for(int j = 0; j < mapSize; j++)
    {
      tiles[i][j].show();
    }
  }
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
  for(int i = 0; i < mapSize; i++)
  {
    for(int j = 0; j < mapSize; j++)
    {
      tiles[i][j].checkForInput(images[0]);
    }
  }
  for(int i = 0; i < 4; i++)
  {
    tileSelect[i].checkForInput();
  }
  if(next.checkForInput() != null)
  {
    turn++;
    tileSelect = next.checkForInput();
    countScore();
    for(int i = 0; i < mapSize; i++)
    {
      for(int j = 0; j < mapSize; j++)
      {
        tiles[i][j].justPlaced = false;
      }
    }
  }
}
public void countScore()
{
  println("Counting score");
  for(int i = 1; i < mapSize; i = i + 2)
  {
    if(tiles[0][i].active)
      if(tiles[i][0].west != 0)
        score += StartCount(0, i, true);
        
    if(tiles[mapSize - 1][i].active)
      if(tiles[i][0].east != 0)
        score += StartCount(mapSize - 1, i, true);
  }
  for(int i = 1; i < mapSize; i = i + 2)
  {
    if(tiles[i][0].active)
      if(tiles[i][0].north != 0)
        score += StartCount(i, 0, true);
    if(tiles[i][mapSize - 1].active)
      if(tiles[i][0].south != 0)
        score += StartCount(i, mapSize - 1, true);
        
  }
  for(int i = 0; i < mapSize; i++)
  {
    for(int j = 0; j < mapSize; j++)
    {
      tiles[i][j].active = true;
    }
  }
}
int StartCount(int x, int y, boolean start)
{
  int score = 0;
  tiles[x][y].active = false;
  score += countEast(x, y, start);
  score += countWest(x, y, start);
  score += countNorth(x, y, start);
  score += countSouth(x, y, start);
  //println("At: " + x + ";" + y);
  return score;
}
int countEast(int x, int y, boolean start)
{
  for(int i = 1; i < mapSize; i = i + 2)
  {
    if(x == mapSize - 1 && y == i)
    {
      if(tiles[x][y].east != 0)
      {
        println("Point from east");
        if(!start) return 1;
        else return 0;
      }
    }
  }
  if(x < mapSize - 1 && tiles[x + 1][y].active && tiles[x][y].east != 0 && tiles[x][y].east == tiles[x + 1][y].west)
  {
    println("Going east");
    return StartCount(x + 1, y, false);
  }
  else 
  {
    println("stopping at " + x +";" + y );
    return 0;
  }
}
int countWest(int x, int y, boolean start)
{
  for(int i = 1; i < mapSize; i = i + 2)
  {
    if(x == 0 && y == i)
    {
      if(tiles[x][y].west != 0)
      {
        println("Point from west");
        if(!start) return 1;
        else return 0;
      }
    }
  }
  if(x > 0 && tiles[x - 1][y].active && tiles[x][y].west != 0 && tiles[x - 1][y].east == tiles[x][y].west)
  {
    println("Going west");
    return StartCount(x - 1, y, false);
  }
  else 
  {
    println("stopping at " + x +";" + y );
    return 0;
  }
}
int countNorth(int x, int y, boolean start)
{
  for(int i = 1; i < mapSize; i = i + 2)
  {
    if(x == i && y == 0)
    {
      if(tiles[x][y].north != 0)
      {
        println("Point from north");
        if(!start) return 1;
        else return 0;
      }
    }
  }
  if(y > 0 && tiles[x][y - 1].active && tiles[x][y].north != 0 && tiles[x][y].north == tiles[x][y - 1].south)
  {
    println("Going north");
    return StartCount(x, y - 1, false);
  }
  else 
  {
    println("stopping at " + x +";" + y );
    return 0;
  }
}
int countSouth(int x, int y, boolean start)
{
  for(int i = 1; i < mapSize; i = i + 2)
  {
    if(x == i && y == mapSize - 1)
    {
      if(tiles[x][y].south != 0)
      {
        println("Point from south");
        if(!start) return 1;
        else return 0;
      }
    }
  }
  if(y < mapSize - 1 && tiles[x][y + 1].active && tiles[x][y].south != 0 && tiles[x][y].south == tiles[x][y + 1].north)
  {
    println("Going south");
    return StartCount(x, y + 1, false);
  }
  else 
  {
    println("stopping at " + x +";" + y);
    return 0;
  }
}

  

PImage[] images = new PImage[9];
PImage rotateImg;
PImage reverseImg;
PImage nextImg;
TileSelect[] tileSelect = new TileSelect[4];
public TileSelect Selected;
public int mapSize = 7;
int turn = 1;
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

  for(int i = 0; i < images.length; i++)
  {
    images[i] = loadImage(filenames[i]);
  }
  for(int i = 0; i < mapSize; i++)
  {
    for(int j = 0; j < mapSize; j++)
    {
      tiles[i][j] = new Tile(images[0], 250 + i*64, 50 + j * 64, 64, 64, 0, 0, 0, 0, i, j);
    }
  }
  next = new NewTurn(80, 350, 130, 50, nextImg);
  tileSelect = next.GenerateNewTiles();
  Selected = tileSelect[0];
}

void draw() {
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
    for(int i = 0; i < mapSize; i++)
    {
      for(int j = 0; j < mapSize; j++)
      {
        tiles[i][j].justPlaced = false;
      }
    }
  }
}
void countScore()
{
  /*
  int score = 0;
  for(int i = 1; < 7; i = i + 2)
  {
    
  }
  for(int i = 1; < 7; i = i + 2)
  {
    
  }
  for(int i = 1; < 7; i = i + 2)
  {
    
  }
  for(int i = 1; < 7; i = i + 2)
  {
    
  }
  */
}

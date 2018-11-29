float carX = 50;
int carY = 50;
int carLength = 50;
int carHeight = 20;
float carSpeed = 0.5;
int wheelSize = 10;
int roadY = 70;
int roadWidth = 15;
int roadLineLenght = 10;
int roadLineMultiplier = 2;
int bulletLength = 10;
int bulletSpeed = 2;
int boxSize = 20;
int boxCount = 30;
int points = 0;
int textSize = 32;
ArrayList<bullet> bullets = new ArrayList<bullet>();
ArrayList<box> boxes = new ArrayList<box>();


void setup()
{
   size(600, 400); 
   for(int i = 0; i < boxCount; i++)
     boxes.add(new box(random(0, width - boxSize), random(carHeight + carY, height - boxSize)));
   
   
}

void draw()
{
  background(255,255,255);
  for(int i = 0; i < width; i = i + roadLineLenght * roadLineMultiplier)
  {
    line(i, roadY, i + roadLineLenght, roadY);
  }
  line(0, roadY - roadWidth, width, roadY - roadWidth);
  line(0, roadY + roadWidth, width, roadY + roadWidth);
  carX +=carSpeed;
  rect(carX,carY, carLength,carHeight);
  ellipse(carX + wheelSize, carY + carHeight,wheelSize, wheelSize);
  ellipse(carX + carLength - wheelSize, carY + carHeight,wheelSize, wheelSize);
  if(carX > width)
  carX = 0;
  for(int i = 0; i < bullets.size(); i++)
  {
    bullet blt  = bullets.get(i);
    blt.update();
    if(blt.ypos > height)
    {
      bullets.remove(i);
      i--;
    }
  }
  for(int i = 0; i < boxes.size(); i++)
  {
    box b = boxes.get(i);
    b.update();
  }
  checkForContact();
  textSize(textSize);
  fill(0,0,0);
  text("Points:" + str(points), 10, 30);
  fill(255,255,255);

  
}
void mouseClicked()
{
  bullets.add(new bullet(carX + carLength/2 , carY));
}
void checkForContact()
{
  for(int i = 0; i < boxes.size(); i++)
  {
    box b = boxes.get(i);
    for(int j = 0; j < bullets.size(); j++)
    {
      bullet blt = bullets.get(j);
      if(b.ypos < blt.ypos + bulletLength && b.ypos + boxSize > blt.ypos + bulletLength)
      {
        if(b.xpos < blt.xpos && b.xpos + boxSize > blt.xpos)
          {
           bullets.remove(j);
           boxes.remove(i);
           i--;
           j--;
           points++;
          }
      }
      
    }
  }
}
class bullet
{
  float xpos, ypos, speed;
  bullet(float x, float y){
   xpos = x;
   ypos = y;
   speed = bulletSpeed;
  }
   void update()
   {
    ypos += speed; 
    line(xpos, ypos, xpos, ypos + bulletLength);
   }
}
class box
{
  float xpos, ypos;
  box(float x, float y){
   xpos = x;
   ypos = y;
  }
  void update()
   {
    rect(xpos, ypos, boxSize, boxSize);
   }
}

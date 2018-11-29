float r = 0;
float t = 0;
float noiseScale = noise(r)*10;

void setup()
{
 size(800,600);
 background(#FFFFFF);
}
void draw()
{
 float x = r * cos(t);
 float y = r * sin(t);
 
  // Draw an ellipse at x,y
  noStroke();
  
  
  
  float n = noise(r) * 20;  
  fill(0,0,n * 10);
  // Adjust for center of window
  ellipse(x+width/2, y+height/2, n, n); 

  float angleIncrement = 0.05;
  angleIncrement = angleIncrement - 0.005;
  // Increment the angle
  t += angleIncrement;
  // Increment the radius
  r += 0.1;
}

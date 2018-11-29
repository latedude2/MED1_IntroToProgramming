class box
{
  float xpos, ypos;
  float boxSize = 20;
  box(float x, float y, float boxSize){
   xpos = x;
   ypos = y;
   this.boxSize = boxSize;
   rect(xpos, ypos, boxSize, boxSize);
  }
}
